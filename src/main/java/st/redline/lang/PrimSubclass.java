/* Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution. */
package st.redline.lang;

import java.util.HashMap;
import java.util.Map;

import st.redline.classloader.SmalltalkClassLoader;

public class PrimSubclass extends ProtoObject {

    public PrimSubclass() {
        name = "PrimSubclass-block";
    }

    protected ProtoObject invoke(ProtoObject receiver, PrimContext context) {
        SmalltalkClassLoader smalltalkClassLoader = classLoader();
        String name = subclassNameFrom(context);
        Map<String, Integer> instVarMap = new HashMap<String,Integer>();
        if (context.arguments != null && context.arguments.length > 1) {
            ProtoObject instVars = context.argumentAt(1);
            if (instVars != null && instVars.javaValue() != null) {
                String[] instVarNames = ((String)instVars.javaValue()).trim().split("\\s+");
                int instVarIndex = 1;
                for (String instVarName : instVarNames) {
                  instVarMap.put(instVarName, instVarIndex++);
                }
            }
        }
        ProtoObject sublcass = createSubclass(smalltalkClassLoader.METACLASS, (ProtoClass) receiver, name, instVarMap);
        registerClass(smalltalkClassLoader, receiver, name, sublcass);
        return sublcass;
    }

    private void registerClass(SmalltalkClassLoader smalltalkClassLoader, ProtoObject receiver, String name, ProtoObject subclass) {
        String fullyQualifiedName = smalltalkClassLoader.currentPackage() + "." + name;
        smalltalkClassLoader.registerSmalltalkClass(fullyQualifiedName, subclass);
    }

    private ProtoObject createSubclass(ProtoObject metaclass, ProtoClass receiver, String name, Map<String,Integer> instVarMap) {
        ProtoClass newMetaclass = ((ProtoClass) receiver.selfclass).subclass();
        newMetaclass.selfclass = metaclass;
        ProtoClass newClass = newMetaclass.create(name, instVarMap);
        newClass.superclass = receiver;
        return newClass;
    }

    private String subclassNameFrom(PrimContext primContext) {
        return (String) primContext.argumentAt(0).javaValue();
    }
}
