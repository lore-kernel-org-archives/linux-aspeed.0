Return-Path: <linux-aspeed+bounces-5217-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D97CCA462
	for <linux-aspeed@archiver.kernel.org>; Fri, 16 Oct 2026 08:54:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5f0111dJz2yTQ;
	Fri, 16 Oct 2026 19:54:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792140897;
	cv=none; b=XXNmthE5V5Kv0v5WhuuMbPxaDWa0Ls0An39WYfFlzezhTt41mOgJkAKotAhHY+UiCJrwfgUwCDEByhl44hP50eeBdj0RTXnj5BSMf7AU0l+b1N4Feu598dzzHN/JV0cCY490mTJbZVwDt8lrwzWcskDJgtMVixRE8VXqEo7uFyN2+GBfkpxYK1fWeSewG6RqXBqENOpDAukEzI99bigNptCiGI5jVDaq+LKDWaEJynQTMeEDITh0dvo2ejTFmjrT9k7czaLGSp1Hf7o4ByQGXwftworpjq24jiOdEeKp0fLyMD6dhZDlkDiw+AewqQhUFkJAE3xl79M6wf7D8x17hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792140897; c=relaxed/relaxed;
	bh=OEmSCrhjQ4YaiiMldBlVpLIsq/kAkmrjHPxuYUWv+lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=eHGP8ZsW8Iu6ITtOeblo2pSYCdhRr7oWJGDagK4IO/rSrFW51oQwQs9wiGUDbz5a2KWUizdysJE3EghjlFdcdi8dm3p1L2YXKEFn8PUIM78k6LLaPs8il0KK8H4YTNAn23TZckFOdz80dnCtcHkY6zeKeIWcIo0g1tXszI3GLRk1yMFY9QKQA8wMbSLFFfgJ3BXyBmR+wuZ58R4CjQZ1muM+77iadV29iP1O4J/Dg2UZsSwyUsaEruRc3+xSYQ3vx7/XCpS6lNY++Hm875A47HYiNHJwvDo/vPFIWWNsfnZi8/xuLVskMoJ01I7irZXBP0lR8DGobIUYkxXPx4Evsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=joe_wang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=joe_wang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5dzz509vz2y2B
	for <linux-aspeed@lists.ozlabs.org>; Fri, 16 Oct 2026 19:54:54 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 16 Oct
 2026 16:54:36 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 16 Oct 2026 16:54:36 +0800
From: Joe Wang <joe_wang@aspeedtech.com>
Date: Fri, 16 Oct 2026 16:53:07 +0800
Subject: [PATCH] usb: ehci: Quiesce ASPEED EHCI before halting it on
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
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261016-upstream_ehci_aspeed_shutdown-v1-1-8440c13b5652@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAPLl0WoC/x3MQQrDIBAF0KuEWVeILgLpVUoRO37rLGrESZpCy
 N0rWb7NO0jRBEr34aCGr6gspcPeBuIcyhtGYje50U12tJPZqq4N4eORWXzQCkSveVvjshczM6e
 E+HLBMvWjNiT5Xf/jeZ5/j16YK28AAAA=
X-Change-ID: 20261016-upstream_ehci_aspeed_shutdown-9ccffedb2a1c
To: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-aspeed@lists.ozlabs.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Joe Wang <joe_wang@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792140876; l=3618;
 i=joe_wang@aspeedtech.com; s=20261016; h=from:subject:message-id;
 bh=P0RTLIbVU2S4X/eL+eds+/vYVZud713p6vOZsXOqWLg=;
 b=ytseTYJOGcUaMaTjhvzjh/sLZZoaaDqml/aubWyh5Rn6i7kNjgDFKTB5J2VAR0+j+8/4D9rS/
 BYj8P930+UGApMDhwcN1aIoRLqUeK3056b608/8tW2bhIiN++B0YNJ2
X-Developer-Key: i=joe_wang@aspeedtech.com; a=ed25519;
 pk=veYVypCO3h8GrodKXAGdE/+hudGfq/xO12Y1lhyRIV0=

On ASPEED EHCI controllers, clearing USBCMD.RS while both the periodic
and asynchronous schedules are enabled may leave the controller unable
to halt. If an asynchronous transaction is in progress when RS is
cleared, it may run past the end of the micro-frame. The controller then
clears its internal schedule buffer at the start of the next micro-frame
while it is already walking the periodic schedule, issues a DMA read
from address 0x0 and never sets USBSTS.HCHalted.

ehci_shutdown() calls ehci_silence_controller(), which halts the
controller without first turning off the schedules. For ASPEED
controllers, call ehci_quiesce() first to clear CMD_ASE/CMD_PSE and
wait for STS_ASS/STS_PSS to clear, as ehci_stop() and
ehci_bus_suspend() already do before halting. This is also the stop
sequence recommended by ASPEED.

Quiesce the controller after setting rh_state to EHCI_RH_STOPPING.
The asynchronous and periodic schedule-enable paths require
EHCI_RH_RUNNING, so this ordering prevents them from restarting the
schedules while the controller is being shut down.

Allow ehci_quiesce() to operate in EHCI_RH_STOPPING as well as
EHCI_RH_RUNNING. As documented for enum ehci_rh_state, both states
indicate that the controller may still be performing DMA, while
lower states indicate that it is not.

The controller-death path in ehci_irq() also sets EHCI_RH_STOPPING
and clears CMD_RUN, CMD_ASE and CMD_PSE. A quiesce call in that
state writes the command register with these bits still cleared
and polls the schedule status bits using the existing timeout
limits, without re-enabling the controller or its schedules.

Signed-off-by: Joe Wang <joe_wang@aspeedtech.com>
---
This issue was observed on a customer host platform using the AST2700
PCIe EHCI (ehci-pci), and the root cause was confirmed by the ASPEED
hardware team in RTL simulation. The stop sequence used here (clear
PSE/ASE, wait for PSS/ASS to clear, then clear RS) is their
recommended workaround and was confirmed to resolve the issue on that
platform. All ASPEED EHCI controllers share the same design, so the
workaround applies to every controller with is_aspeed set.

The quiesce is limited to ASPEED controllers to keep the change
minimal for other platforms.

Tested on AST2700 (ehci-platform): ehci_shutdown() and unbind/bind
(ehci_stop()) with a hub and USB mass storage under load, no
regressions.
---
 drivers/usb/host/ehci-hcd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 3c46bb18c7f3..d984987c8691 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -274,7 +274,7 @@ static void ehci_quiesce (struct ehci_hcd *ehci)
 {
 	u32	temp;
 
-	if (ehci->rh_state != EHCI_RH_RUNNING)
+	if (ehci->rh_state < EHCI_RH_RUNNING)
 		return;
 
 	/* wait for any schedule enables/disables to take effect */
@@ -372,6 +372,14 @@ static void ehci_shutdown(struct usb_hcd *hcd)
 	ehci->enabled_hrtimer_events = 0;
 	spin_unlock_irq(&ehci->lock);
 
+	/*
+	 * ASPEED EHCI may never halt if RS is cleared while both schedules
+	 * are enabled, so turn them off first. rh_state is STOPPING at this
+	 * point, which keeps them from being re-enabled.
+	 */
+	if (ehci->is_aspeed)
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


