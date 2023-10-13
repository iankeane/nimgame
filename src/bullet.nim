# {.passC: "-I../thirdparty/JoltC".}
# {.passC: "/std:c11".}
# {.link: "/usr/local/lib/libBulletCollision.dylib".}

{. passC:"-I/usr/local/include/bullet" .}
{. passL:"-L/usr/local/lib -lBulletDynamics -lBulletCollision -lLinearMath" .}

# {.push header: "<btBulletDynamicsCommon.h>".}

type
  BtDefaultCollisionConfiguration* {.importcpp: "btDefaultCollisionConfiguration", header: "<btBulletDynamicsCommon.h>".} = object
  BtCollisionDispatcher* {.importcpp: "btCollisionDispatcher", header: "<btBulletDynamicsCommon.h>".} = object
  BtBroadphaseInterface* {.importcpp: "btDbvtBroadphase", header: "<btBulletDynamicsCommon.h>".} = object
  BtSequentialImpulseConstraintSolver* {.importcpp: "btSequentialImpulseConstraintSolver", header: "<btBulletDynamicsCommon.h>".} = object
  BtDiscreteDynamicsWorld* {.importcpp: "btDiscreteDynamicsWorld", header: "<btBulletDynamicsCommon.h>".} = object
  # BtVector3* = object
  BtVector3 {.importcpp: "btVector3", header: "bullet/LinearMath/btVector3.h".} = object
  # BtTransform* = object
  # BtQuaternion* = object
  # BtCollisionShape* = object of RootObj
  BtCollisionShape* {.importcpp: "btCollisionShape", header: "bullet/BulletCollision/CollisionShapes/btCollisionShape.h".} = object of RootObj

  # BtBoxShape* = object of BtCollisionShape  # Indicating the relationship here
  BtBoxShape* {.importcpp: "btBoxShape", header: "bullet/BulletCollision/CollisionShapes/btBoxShape.h".} = object of BtCollisionShape

  # BtDefaultMotionState* = object
  # BtRigidBodyConstructionInfo* = object
  # BtRigidBody* = object
  BtQuaternion* {.importcpp: "btQuaternion", header: "bullet/LinearMath/btQuaternion.h".} = object
  BtTransform* {.importcpp: "btTransform", header: "bullet/LinearMath/btTransform.h".} = object
  BtDefaultMotionState* {.importcpp: "btDefaultMotionState", header: "bullet/LinearMath/btDefaultMotionState.h".} = object of BtMotionState
  BtRigidBody* {.importcpp: "btRigidBody", header: "bullet/BulletDynamics/Dynamics/btRigidBody.h".} = object
  BtRigidBodyConstructionInfo* {.importcpp: "btRigidBody::btRigidBodyConstructionInfo", header: "bullet/BulletDynamics/Dynamics/btRigidBody.h".} = object
  BtMotionState* {.importcpp: "btMotionState", header: "<btBulletDynamicsCommon.h>".} = object of RootObj




proc btNewDefaultCollisionConfiguration*(): ptr BtDefaultCollisionConfiguration {.importcpp: "new btDefaultCollisionConfiguration()".}
proc btNewCollisionDispatcher*(collisionConfiguration: ptr BtDefaultCollisionConfiguration): ptr BtCollisionDispatcher {.importcpp: "new btCollisionDispatcher(@)".}
proc btNewBroadphaseInterface*(): ptr BtBroadphaseInterface {.importcpp: "new btDbvtBroadphase()".}
proc btNewSequentialImpulseConstraintSolver*(): ptr BtSequentialImpulseConstraintSolver {.importcpp: "new btSequentialImpulseConstraintSolver()".}
proc btNewDiscreteDynamicsWorld*(dispatcher: ptr BtCollisionDispatcher, overlappingPairCache: ptr BtBroadphaseInterface, solver: ptr BtSequentialImpulseConstraintSolver, collisionConfiguration: ptr BtDefaultCollisionConfiguration): ptr BtDiscreteDynamicsWorld {.importcpp: "new btDiscreteDynamicsWorld(@)".}
proc btVector3*(x, y, z: cfloat): BtVector3 {.importcpp: "btVector3(@)".}
# proc btVector3*(x, y, z: cfloat): ptr BtVector3 {.importcpp: "new btVector3(@)".}
proc setGravity*(world: ptr BtDiscreteDynamicsWorld, gravity: BtVector3) {.importcpp: "#.setGravity(#)".}
proc initBtBoxShape*(halfExtents: BtVector3): BtBoxShape {.importcpp: "btBoxShape(@)".}
proc calculateLocalInertia*(shape: ptr BtCollisionShape, mass: cfloat, inertia: ptr BtVector3) {.importcpp: "#.calculateLocalInertia(@)".}

# Constructor for BtTransform that takes a BtQuaternion for rotation and a BtVector3 for translation.
proc initBtTransform*(rotation: BtQuaternion, origin: BtVector3): BtTransform {.importcpp: "btTransform(@)".}

# Constructor for BtQuaternion which will be used for rotations.
proc initBtQuaternion*(x, y, z, w: cfloat): BtQuaternion {.importcpp: "btQuaternion(@)".}

proc setIdentity*(trans: ptr BtTransform) {.importcpp: "#.setIdentity()".}
proc setOrigin*(trans: ptr BtTransform, origin: BtVector3) {.importcpp: "#.setOrigin(#)".}

proc initBtDefaultMotionState*(startTransform: BtTransform): BtDefaultMotionState {.importcpp: "btDefaultMotionState(@)".}
proc initBtRigidBodyConstructionInfo*(mass: cfloat, motionState: ptr BtDefaultMotionState,
                                      collisionShape: ptr BtCollisionShape,
                                      localInertia: BtVector3): BtRigidBodyConstructionInfo {.importcpp: "btRigidBody::btRigidBodyConstructionInfo(@)".}
proc initBtRigidBody*(constructionInfo: BtRigidBodyConstructionInfo): BtRigidBody {.importcpp: "btRigidBody(@)".}
proc addRigidBody*(world: ptr BtDiscreteDynamicsWorld, body: ptr BtRigidBody) {.importcpp: "#.addRigidBody(@)".}
proc stepSimulation*(world: ptr BtDiscreteDynamicsWorld, timeStep: cfloat,
                     maxSubSteps: cint = 10, fixedTimeStep: cfloat = 1.0 / 60.0) {.importcpp: "#.stepSimulation(@)".}
# proc getWorldTransform*(state: ptr BtMotionState, transform: ptr BtTransform) {.importcpp: "#.getWorldTransform(@)".}
# proc getWorldTransform*(body: ptr BtRigidBody, transform: ptr BtTransform) {.importcpp: "#.getWorldTransform(@)".}
proc getWorldTransform*(self: BtRigidBody): BtTransform {.importcpp: "#.getWorldTransform()".}

# {.pop.}
