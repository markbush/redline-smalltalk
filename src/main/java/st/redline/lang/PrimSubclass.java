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
        Map<String, Integer> instVarMap = extractInstanceVariables(context);
        ProtoObject subclass = createSubclass(smalltalkClassLoader.METACLASS, (ProtoClass) receiver, name, instVarMap);
        registerClass(smalltalkClassLoader, receiver, name, subclass);
        addMetaclassInstanceVariables(context, subclass);
        return subclass;
    }

    private void addMetaclassInstanceVariables(PrimContext context, ProtoObject subclass) {
        if (subclass instanceof ProtoClass) {
            ProtoClass newClass = (ProtoClass)subclass;
            ProtoObject metaclassObject = newClass.selfclass;
            if (metaclassObject instanceof ProtoClass) {
                ProtoClass metaclass = (ProtoClass)metaclassObject;
                Map<String, Integer> classVarMap = extractClassVariables(context);
                if (metaclass.variableIndexes == null) {
                    metaclass.variableIndexes = new HashMap<String, Integer>();
                }
                int attributeSize = metaclass.addSuperclassInstanceVariables(metaclass.superclass);
                metaclass.addThisClassInstanceVariables(classVarMap, attributeSize);
                attributeSize += classVarMap.size();
                if (attributeSize > 0) {
                    metaclass.attributes = new ProtoObject[attributeSize + 1];
              }
            }
        }
    }

    private Map<String, Integer> extractInstanceVariables(PrimContext context) {
      Map<String, Integer> instVarMap = new HashMap<String,Integer>();
        if (context.arguments != null && context.arguments.length > 1) {
            ProtoObject instVars = context.argumentAt(1);
            if (instVars != null && instVars.javaValue() != null && !((String)instVars.javaValue()).trim().equals("")) {
                String[] instVarNames = ((String)instVars.javaValue()).trim().split("\\s+");
                int instVarIndex = 1;
                for (String instVarName : instVarNames) {
                    // Instance vars must start with a lower case character
                    if (Character.isLowerCase(instVarName.codePointAt(0))) {
                        instVarMap.put(instVarName, instVarIndex++);
                    }
                }
            }
        }
        return instVarMap;
    }

    private Map<String, Integer> extractClassVariables(PrimContext context) {
      Map<String, Integer> classVarMap = new HashMap<String,Integer>();
        if (context.arguments != null && context.arguments.length > 2) {
            ProtoObject classVars = context.argumentAt(2);
            if (classVars != null && classVars.javaValue() != null && !((String)classVars.javaValue()).trim().equals("")) {
                String[] classVarNames = ((String)classVars.javaValue()).trim().split("\\s+");
                int classVarIndex = 1;
                for (String classVarName : classVarNames) {
                    // Class vars must start with an upper case character
                    if (Character.isUpperCase(classVarName.codePointAt(0))) {
                        classVarMap.put(classVarName, classVarIndex++);
                    }
                }
            }
        }
        return classVarMap;
    }

    private void registerClass(SmalltalkClassLoader smalltalkClassLoader, ProtoObject receiver, String name, ProtoObject subclass) {
        String fullyQualifiedName = smalltalkClassLoader.currentPackage() + "." + name;
        smalltalkClassLoader.registerSmalltalkClass(fullyQualifiedName, subclass);
    }

    private ProtoObject createSubclass(ProtoObject metaclass, ProtoClass receiver, String name,
                                       Map<String,Integer> instVarMap) {
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
