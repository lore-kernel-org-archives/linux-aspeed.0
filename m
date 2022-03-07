From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 7 Mar 2022 18:00:37 +0300
Subject: [PATCH 0/6] Remove usage of list iterator past the loop body
In-Reply-To: <20220228110822.491923-1-jakobkoschel@gmail.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
Message-ID: <20220307150037.GD3293@kadam>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Updating this API is risky because some places rely on the old behavior
and not all of them have been updated.  Here are some additional places
you might want to change.

drivers/usb/host/uhci-q.c:466 link_async() warn: iterator used outside loop: 'pqh'
drivers/infiniband/core/mad.c:968 ib_get_rmpp_segment() warn: iterator used outside loop: 'mad_send_wr->cur_seg'
drivers/opp/debugfs.c:208 opp_migrate_dentry() warn: iterator used outside loop: 'new_dev'
drivers/staging/greybus/audio_codec.c:602 gbcodec_mute_stream() warn: iterator used outside loop: 'module'
drivers/staging/media/atomisp/pci/atomisp_acc.c:508 atomisp_acc_load_extensions() warn: iterator used outside loop: 'acc_fw'
drivers/perf/thunderx2_pmu.c:814 tx2_uncore_pmu_init_dev() warn: iterator used outside loop: 'rentry'
drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c:111 nvkm_control_mthd_pstate_attr() warn: iterator used outside loop: 'pstate'
drivers/gpu/drm/panfrost/panfrost_mmu.c:203 panfrost_mmu_as_get() warn: iterator used outside loop: 'lru_mmu'
drivers/media/usb/uvc/uvc_v4l2.c:885 uvc_ioctl_enum_input() warn: iterator used outside loop: 'iterm'
drivers/media/usb/uvc/uvc_v4l2.c:896 uvc_ioctl_enum_input() warn: iterator used outside loop: 'iterm'
drivers/scsi/dc395x.c:3596 device_alloc() warn: iterator used outside loop: 'p'
drivers/net/ethernet/mellanox/mlx4/alloc.c:379 __mlx4_alloc_from_zone() warn: iterator used outside loop: 'curr_node'
fs/ocfs2/dlm/dlmdebug.c:573 lockres_seq_start() warn: iterator used outside loop: 'res'

This patchset fixes 3 bugs.  Initially when it's merged it's probably
going to introduce some bugs because there are likely other places which
rely on the old behavior.

In an ideal world, with the new API the compiler would warn about
uninitialized variables, but unfortunately that warning is disabled by
default so we still have to rely on kbuild/Clang/Smatch to find the
bugs.

But hopefully the new API encourages people to write clearer code so it
prevents bugs in the long run.

regards,
dan carpenter

