/* Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution */
package st.redline.lang;

// Adds block functionality

import java.lang.reflect.InvocationTargetException;

import st.redline.compiler.ast.Block;

public class ProtoBlock extends ProtoObject {

    protected static ProtoObject blockClosure;

    private boolean methodBlock = false;
    private PrimContext outerContext;
    private Block block;

    public ProtoBlock() {
        this(null);
    }

    public ProtoBlock(PrimContext outerContext) {
        name = "Block";
        selfclass = resolveBlockClosure();
        this.outerContext = outerContext;
    }

    public Block block() {
        return block;
    }

    public void block(Block block) {
        this.block = block;
    }

    protected ProtoObject resolveBlockClosure() {
        if (blockClosure != null)
            return blockClosure;
        if (classLoader().isBootstrapping())
            return PrimNil.PRIM_NIL;
        blockClosure = resolveObject("st.redline.kernel.BlockClosure");
        return blockClosure;
    }

    public ProtoObject outerReceiver() {
        ProtoObject receiver = outerContext.receiver;
        while (receiver instanceof ProtoBlock) {
            receiver = ((ProtoBlock)receiver).outerContext.receiver;
        }
        return receiver;
    }

    public ProtoObject variableAt(String name) {
        if (block != null) {
            if (block.isOuterTemporary(name)) {
                int index = block.outerTemporary(name);
                return outerContext.temporaryAt(index);
            }
            if (block.isOuterArgument(name)) {
                int index = block.outerArgument(name);
                return outerContext.argumentAt(index);
            }
        }
        int index = selfclass.indexOfVariable(name);
        if (index != 0)
            return attributes[index];
        return outerContext.receiver.variableAt(name);
    }

    public ProtoObject variableAtPut(String name, ProtoObject object) {
        if (block != null) {
            if (block.isOuterTemporary(name)) {
                int index = block.outerTemporary(name);
                outerContext.temporaryAtPut(index, object);
                return this;
            }
        }
        int index = selfclass.indexOfVariable(name);
        if (index != 0) {
            attributes[index] = object;
            return this;
        }
        outerContext.receiver.variableAtPut(name, object);
        return this;
    }

    public PrimContext outerContext() {
        return outerContext;
    }

    public void markAsMethodBlock() {
        methodBlock = true;
    }

    public boolean isMethodBlock() {
        return methodBlock;
    }

    public boolean notMethodBlock() {
        return !isMethodBlock();
    }

    public ProtoObject answer(ProtoObject answer, String blockReturnType) {
        if (notMethodBlock())
            throwAnswer(answer, blockReturnType);
        return answer;
    }

    public void throwAnswer(ProtoObject answer, String blockReturnType) {
        try {
//            System.out.println("throwAnswer: " + answer);
            throw (BlockReturn) classLoader()
                                    .loadBlockReturn(blockReturnType)
                                    .getConstructor(ProtoObject.class)
                                    .newInstance(answer);
        } catch (InstantiationException e) {
            throw new RuntimeException(e);
        } catch (IllegalAccessException e) {
            throw new RuntimeException(e);
        } catch (InvocationTargetException e) {
            throw new RuntimeException(e);
        } catch (NoSuchMethodException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

}
