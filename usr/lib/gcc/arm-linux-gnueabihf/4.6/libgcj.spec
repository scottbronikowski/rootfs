#
# This spec file is read by gcj when linking.
# It is used to specify the standard libraries we need in order
# to link with libgcj.
#
%rename startfile startfileorig
*startfile:  %(startfileorig)

%rename lib liborig
*lib: %{static-libgcj:-non_shared} %{static|static-libgcj|!s-bc-abi:-lgcj;:-lgcj_bc} %{static-libgcj:-call_shared} -lm     -lpthread -lrt -lz  --no-merge-exidx-entries  -ldl %(libgcc) -lstdc++ %(liborig)

*jc1:  -fuse-divide-subroutine -fcheck-references -fuse-boehm-gc    -fuse-atomic-builtins %{findirect-dispatch:-fPIC} -fkeep-inline-functions
