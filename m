Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1159B606A319
	for <linux-aspeed@archiver.kernel.org>; Thu, 22 Oct 2026 01:21:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j97f42Tp5z2xM7;
	Thu, 22 Oct 2026 12:21:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792632092;
	cv=none; b=F03v9KWy0VaF2PBwIy30ERNFn9j1HtF87dtrc6tIITNqXOap3gBSvrcrDH6aJxiXnJQNroixD584aknYvrKHTYTK/D6Yw8t2byDoeZVGFB7b4wxVvh8hBfPea4fUyYh4Xe1EL9j8w0gYILtEmlrtsM3qzbzRDNH2daTiI+YzuPN2BwieuIwi2yWNCjMeezmtL2agGVbrsxpfj7d+QQQj6V18r6cfYWuPD/rMqTrdEN1X5v4I7ZtUojToNp35kpk45uyEJplPjQE6/pl/+r3UjDuqQs374c2vmZSGLdecZRGbVp/u956v/HfX3ctprRSw/f+879/k/HOamFWQSSN6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792632092; c=relaxed/relaxed;
	bh=Dn3/jAL6v6ghW9rsuVgKy3lfCm6I490PGsSIGAlPjMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=eT3pLyMn2kU7STn2slVwLt3CGT70lNiL7i7c3ySjPh+RCVRV+1MdeF9ieH3Cnfbz7v0Rz809o19ylKSyA4CGahNHwVmZuY9iFxZSu9sNvnwO9cC9auX1RD+Vn1FK6w5O8brPyudnX0+ST2xlNpVBRLrSxyAp9rrEsV40EniOtfwg2LeUwSTAlbPylNtEPC5oxoyDiLY6jsyZGQK8T4C4QMkB6FobE6JeyCqibYD5mbRvy8O98LEAti2Eft2+0JIbdL3vBPkkyYAihozWrBv8VpobUy6Pubot8pq5zOpRameXPlrhwFH3k3DJpHKyV0T214ZmkEG9qoOI36rHpIusGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=joe_wang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=joe_wang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j97f26RLsz2xLm
	for <linux-aspeed@lists.ozlabs.org>; Thu, 22 Oct 2026 12:21:30 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 22 Oct
 2026 09:21:12 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 22 Oct 2026 09:21:12 +0800
From: Joe Wang <joe_wang@aspeedtech.com>
Date: Thu, 22 Oct 2026 09:21:11 +0800
Subject: [PATCH v2] usb: ehci: Quiesce controller before halting it on
 shutdown
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261022-upstream_ehci_aspeed_shutdown-v2-1-62712169bc07@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAAZl2WoC/42NQQ6CMBBFr0K6toapQNSV9zCElOlgZwFt2oIaw
 t2teAGX7+Xn/VVECkxRXItVBFo4spsyqEMh0OrpQZJNZqFK1UAJjZx9TIH02JFF7nT0RKaLdk7
 GPSd5QRwGMr3SgCI3fKCBX3v/3ma2HJML7/1uga/9t7yABHmuqhLh1NdNrW6/RSK0R3SjaLdt+
 wCn7KqPzwAAAA==
X-Change-ID: 20261016-upstream_ehci_aspeed_shutdown-9ccffedb2a1c
To: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-aspeed@lists.ozlabs.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Joe Wang <joe_wang@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792632072; l=3828;
 i=joe_wang@aspeedtech.com; s=20261016; h=from:subject:message-id;
 bh=OSAHWQ2UPz1PWu1SvvyU1LUnKZDP/P2ec1W7JWtFSBo=;
 b=svrsK9ZFUVBKji/t0Ki3qDbxFdI4aYYT1JuV+EeEYxpDLqB0I1HcFjXMdICGnpyvIwvJqjRbx
 HeYEGyEIgy9DGDrNrRkDBP7RrpmEy05txsGEPrINz7oP9rbvqVGSMs/
X-Developer-Key: i=joe_wang@aspeedtech.com; a=ed25519;
 pk=veYVypCO3h8GrodKXAGdE/+hudGfq/xO12Y1lhyRIV0=
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ehci_shutdown() runs from the .shutdown callback during reboot,
poweroff and kexec, for example when LinuxBoot firmware boots the
final OS. The HCD is not removed in that path, so ehci_stop() is not
called and the controller may still be running. ehci_shutdown() then
halts it without first turning off the schedules, leaving a DMA master
running while the system shuts down.

On ASPEED EHCI controllers, clearing USBCMD.RS while both the periodic
and asynchronous schedules are enabled may also leave the controller
unable to halt. If an asynchronous transaction runs past the end of
the micro-frame after RS is cleared, the controller walks the periodic
schedule with a cleared internal buffer, reads from address 0x0 and
never sets USBSTS.HCHalted.

If the controller was running, call ehci_quiesce() before halting it,
as ehci_stop() and ehci_bus_suspend() already do. Do this after
rh_state is set to EHCI_RH_STOPPING, so that URB submissions and
hrtimer events cannot re-enable the schedules, and let ehci_quiesce()
accept that state: like EHCI_RH_RUNNING, it means the controller may
still be doing DMA. The controller-death path in ehci_irq() also sets
EHCI_RH_STOPPING, but it has already cleared CMD_RUN, CMD_ASE and
CMD_PSE, so a quiesce there cannot re-enable anything.

Signed-off-by: Joe Wang <joe_wang@aspeedtech.com>
---
This issue was observed on a customer host platform using the AST2700
PCIe EHCI (ehci-pci), and the root cause was confirmed by the ASPEED
hardware team in RTL simulation. The stop sequence used here (clear
PSE/ASE, wait for PSS/ASS to clear, then clear RS) is their
recommended workaround and was confirmed to resolve the issue on that
platform.

When the controller is running, the added delay at shutdown is bounded
by the two existing 16-uframe handshakes in ehci_quiesce().

Tested on AST2700 (ehci-platform): reboot with a hub and USB mass
storage under load, ehci_shutdown() on already halted controllers,
and unbind/bind (ehci_stop()); no regressions.
---
Changes in v2:
- Apply to all EHCI controllers, not only ASPEED (Alan)
- Quiesce only if the controller was running (Alan)
- Link to v1: https://lore.kernel.org/r/20261016-upstream_ehci_aspeed_shutdown-v1-1-8440c13b5652@aspeedtech.com
---
 drivers/usb/host/ehci-hcd.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 3c46bb18c7f3..d9d816eedc66 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -274,7 +274,7 @@ static void ehci_quiesce (struct ehci_hcd *ehci)
 {
 	u32	temp;
 
-	if (ehci->rh_state != EHCI_RH_RUNNING)
+	if (ehci->rh_state < EHCI_RH_RUNNING)
 		return;
 
 	/* wait for any schedule enables/disables to take effect */
@@ -356,6 +356,7 @@ static void ehci_silence_controller(struct ehci_hcd *ehci)
 static void ehci_shutdown(struct usb_hcd *hcd)
 {
 	struct ehci_hcd	*ehci = hcd_to_ehci(hcd);
+	bool		was_running;
 
 	/**
 	 * Protect the system from crashing at system shutdown in cases where
@@ -367,11 +368,19 @@ static void ehci_shutdown(struct usb_hcd *hcd)
 		return;
 
 	spin_lock_irq(&ehci->lock);
+	was_running = ehci->rh_state == EHCI_RH_RUNNING;
 	ehci->shutdown = true;
 	ehci->rh_state = EHCI_RH_STOPPING;
 	ehci->enabled_hrtimer_events = 0;
 	spin_unlock_irq(&ehci->lock);
 
+	/*
+	 * Turn off the schedules before halting. rh_state is STOPPING now,
+	 * so they cannot be re-enabled.
+	 */
+	if (was_running)
+		ehci_quiesce(ehci);
+
 	ehci_silence_controller(ehci);
 
 	hrtimer_cancel(&ehci->hrtimer);

---
base-commit: 2f2f7eeef8b0a1a9b9ca998231419873ccae8d4e
change-id: 20261016-upstream_ehci_aspeed_shutdown-9ccffedb2a1c

Best regards,
-- 
Joe Wang <joe_wang@aspeedtech.com>


