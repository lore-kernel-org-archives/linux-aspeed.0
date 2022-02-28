From: Jakob Koschel <jakobkoschel@gmail.com>
Date: Mon, 28 Feb 2022 12:08:16 +0100
Subject: [PATCH 0/6] Remove usage of list iterator past the loop body
Message-ID: <20220228110822.491923-1-jakobkoschel@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This is the first patch removing several categories of use cases of
the list iterator variable past the loop.
This is follow up to the discussion in:
https://lore.kernel.org/all/20220217184829.1991035-1-jakobkoschel at gmail.com/

As concluded in:
https://lore.kernel.org/all/YhdfEIwI4EdtHdym at kroah.com/
the correct use should be using a separate variable after the loop
and using a 'tmp' variable as the list iterator.
The list iterator will not point to a valid structure after the loop
if no break/goto was hit. Invalid uses of the list iterator variable
can be avoided altogether by simply using a separate pointer to
iterate the list.

Linus and Greg agreed on the following pattern:

-	struct gr_request *req;
+	struct gr_request *req = NULL;
+	struct gr_request *tmp;
	struct gr_ep *ep;
	int ret = 0;

-	list_for_each_entry(req, &ep->queue, queue) {
-		if (&req->req == _req)
+	list_for_each_entry(tmp, &ep->queue, queue) {
+		if (&tmp->req == _req) {
+			req = tmp;
			break;
+		}
	}
-	if (&req->req != _req) {
+	if (!req) {
		ret = -EINVAL;
		goto out;
	}


With gnu89 the list iterator variable cannot yet be declared
within the for loop of the list iterator.
Moving to a more modern version of C would allow defining
the list iterator variable within the macro, limiting
the scope to the loop.
This avoids any incorrect usage past the loop altogether.

This are around 30% of the cases where the iterator
variable is used past the loop (identified with a slightly
modified version of use_after_iter.cocci).
I've decided to split it into at a few patches separated
by similar use cases.

Because the output of get_maintainer.pl was too big,
I included all the found lists and everyone from the
previous discussion.

Jakob Koschel (6):
  drivers: usb: remove usage of list iterator past the loop body
  treewide: remove using list iterator after loop body as a ptr
  treewide: fix incorrect use to determine if list is empty
  drivers: remove unnecessary use of list iterator variable
  treewide: remove dereference of list iterator after loop body
  treewide: remove check of list iterator against head past the loop
    body

 arch/arm/mach-mmp/sram.c                      |  9 ++--
 arch/arm/plat-pxa/ssp.c                       | 28 +++++-------
 arch/powerpc/sysdev/fsl_gtm.c                 |  4 +-
 arch/x86/kernel/cpu/sgx/encl.c                |  6 ++-
 drivers/block/drbd/drbd_req.c                 | 45 ++++++++++++-------
 drivers/counter/counter-chrdev.c              | 26 ++++++-----
 drivers/crypto/cavium/nitrox/nitrox_main.c    | 11 +++--
 drivers/dma/dw-edma/dw-edma-core.c            |  4 +-
 drivers/dma/ppc4xx/adma.c                     | 11 +++--
 drivers/firewire/core-transaction.c           | 32 +++++++------
 drivers/firewire/sbp2.c                       | 14 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 19 +++++---
 drivers/gpu/drm/drm_memory.c                  | 15 ++++---
 drivers/gpu/drm/drm_mm.c                      | 17 ++++---
 drivers/gpu/drm/drm_vm.c                      | 13 +++---
 drivers/gpu/drm/gma500/oaktrail_lvds.c        |  9 ++--
 drivers/gpu/drm/i915/gem/i915_gem_context.c   | 14 +++---
 .../gpu/drm/i915/gem/i915_gem_execbuffer.c    | 15 ++++---
 drivers/gpu/drm/i915/gt/intel_ring.c          | 15 ++++---
 .../gpu/drm/nouveau/nvkm/subdev/clk/base.c    | 11 +++--
 .../gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c | 13 +++---
 drivers/gpu/drm/scheduler/sched_main.c        | 14 +++---
 drivers/gpu/drm/ttm/ttm_bo.c                  | 19 ++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c           | 22 +++++----
 drivers/infiniband/hw/hfi1/tid_rdma.c         | 16 ++++---
 drivers/infiniband/hw/mlx4/main.c             | 12 ++---
 drivers/media/dvb-frontends/mxl5xx.c          | 11 +++--
 drivers/media/pci/saa7134/saa7134-alsa.c      |  4 +-
 drivers/media/v4l2-core/v4l2-ctrls-api.c      | 31 +++++++------
 drivers/misc/mei/interrupt.c                  | 12 ++---
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  3 +-
 .../net/ethernet/qlogic/qede/qede_filter.c    | 11 +++--
 drivers/net/wireless/ath/ath6kl/htc_mbox.c    |  2 +-
 .../net/wireless/intel/ipw2x00/libipw_rx.c    | 15 ++++---
 drivers/perf/xgene_pmu.c                      | 13 +++---
 drivers/power/supply/cpcap-battery.c          | 11 +++--
 drivers/scsi/lpfc/lpfc_bsg.c                  | 16 ++++---
 drivers/scsi/scsi_transport_sas.c             | 17 ++++---
 drivers/scsi/wd719x.c                         | 12 +++--
 drivers/staging/rtl8192e/rtl819x_TSProc.c     | 17 +++----
 drivers/staging/rtl8192e/rtllib_rx.c          | 17 ++++---
 .../staging/rtl8192u/ieee80211/ieee80211_rx.c | 15 ++++---
 .../rtl8192u/ieee80211/rtl819x_TSProc.c       | 19 ++++----
 drivers/thermal/thermal_core.c                | 38 ++++++++++------
 drivers/usb/gadget/composite.c                |  9 ++--
 drivers/usb/gadget/configfs.c                 | 22 +++++----
 drivers/usb/gadget/udc/aspeed-vhub/epn.c      | 11 +++--
 drivers/usb/gadget/udc/at91_udc.c             | 26 ++++++-----
 drivers/usb/gadget/udc/atmel_usba_udc.c       | 11 +++--
 drivers/usb/gadget/udc/bdc/bdc_ep.c           | 11 +++--
 drivers/usb/gadget/udc/fsl_qe_udc.c           | 11 +++--
 drivers/usb/gadget/udc/fsl_udc_core.c         | 11 +++--
 drivers/usb/gadget/udc/goku_udc.c             | 11 +++--
 drivers/usb/gadget/udc/gr_udc.c               | 11 +++--
 drivers/usb/gadget/udc/lpc32xx_udc.c          | 11 +++--
 drivers/usb/gadget/udc/max3420_udc.c          | 11 +++--
 drivers/usb/gadget/udc/mv_u3d_core.c          | 11 +++--
 drivers/usb/gadget/udc/mv_udc_core.c          | 11 +++--
 drivers/usb/gadget/udc/net2272.c              | 12 ++---
 drivers/usb/gadget/udc/net2280.c              | 11 +++--
 drivers/usb/gadget/udc/omap_udc.c             | 11 +++--
 drivers/usb/gadget/udc/pxa25x_udc.c           | 11 +++--
 drivers/usb/gadget/udc/s3c-hsudc.c            | 11 +++--
 drivers/usb/gadget/udc/tegra-xudc.c           | 11 +++--
 drivers/usb/gadget/udc/udc-xilinx.c           | 11 +++--
 drivers/usb/mtu3/mtu3_gadget.c                | 11 +++--
 drivers/usb/musb/musb_gadget.c                | 11 +++--
 drivers/vfio/mdev/mdev_core.c                 | 11 +++--
 fs/cifs/smb2misc.c                            | 10 +++--
 fs/f2fs/segment.c                             |  9 ++--
 fs/proc/kcore.c                               | 13 +++---
 kernel/debug/kdb/kdb_main.c                   | 36 +++++++++------
 kernel/power/snapshot.c                       | 10 +++--
 kernel/trace/ftrace.c                         | 22 +++++----
 kernel/trace/trace_eprobe.c                   | 15 ++++---
 kernel/trace/trace_events.c                   | 11 ++---
 net/9p/trans_xen.c                            | 11 +++--
 net/ipv4/udp_tunnel_nic.c                     | 10 +++--
 net/tipc/name_table.c                         | 11 +++--
 net/tipc/socket.c                             | 11 +++--
 net/xfrm/xfrm_ipcomp.c                        | 11 +++--
 sound/soc/intel/catpt/pcm.c                   | 13 +++---
 sound/soc/sprd/sprd-mcdt.c                    | 13 +++---
 83 files changed, 708 insertions(+), 465 deletions(-)


base-commit: 7ee022567bf9e2e0b3cd92461a2f4986ecc99673
--
2.25.1
