Return-Path: <linux-aspeed+bounces-3759-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72619E9A77E
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Mar 2026 22:51:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgQJR3b15z2ynn;
	Wed, 25 Mar 2026 09:51:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774288690;
	cv=none; b=SvILixPfLLRjvPjrko29rs+56KVd73+gi91JSjtOsGhej7DD7afLK720Kl+bgpMIxY51yKE9icIplHIKhAqebpP+TRtSZ8CtBoeujHLkXrr9OYcnHj5U/vavrynq8V0Cz/YHg1Amiq2i46L3tCBOc8ceQmzIpDx/Z15XT2FOuEoDDAGwu5A+ulYEEEmXjv1YfWwTW+JBl/u635s3Hoc+dAeJUl2sY8QFwrxx8hXM4Wji/VkPTKawd1R3LBmAvrdTRFVeFciJUpQ2fVxyA3nsJIIZEmMmfxRAGFe6kZugUPpZiHd6XQrwoFVXeU4AH2lJNNNHkBKudPsYrJaF+F1cpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774288690; c=relaxed/relaxed;
	bh=DAFVmIYqCpTk7YHQuUKCiaGw6d7SaBhhkzvznBNGhns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fSZImmjMLG7KmnDDqwGybXU+yzOfdVtKIxpSedq82d3tqTi144TTKJYkis/dmQx4+FJPd0c52nDtIzEr318tCMB6yUq8+hoI1x1oLwlXCrAWkh+fovGXeVjoUYGbWoIYVAa2q/EALTTQKxZzjZHdIEo210QMaM/z0AtldT3MCOMFWoDgEKY1UihM3LAtcY6Zq1wl9XxUtMsEq7EeGwczi6iObVFINpy9MDM9agk0aV5c2p36dApkok4AH9MSb6VneU90i9T3lHAC9xIqb7/dxNisyg/JZu9SpfaSWhce0WQtaEwxrGIOvt9uin61QqOD4lTAxfOriTzyfzgvGnHj3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ra4MmNX3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=ustc.gu@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ra4MmNX3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=ustc.gu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffgrJ55hrz2xs4
	for <linux-aspeed@lists.ozlabs.org>; Tue, 24 Mar 2026 04:58:07 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2b056b7f783so23064935ad.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Mar 2026 10:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774288685; x=1774893485; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DAFVmIYqCpTk7YHQuUKCiaGw6d7SaBhhkzvznBNGhns=;
        b=ra4MmNX3Y8dbdcacJXQ779O9dOosbNMRXjKO7iGqWbUOVS+8EGIK6Z+Z75lbOBmTHT
         bJD6IGq29PPlgKd7oJpFTPKNuo1w+yOXcpixi9//ZKXifkK+kGJQIbqmbbAyJWhaRlkm
         U48vxfVyvkpppoBKQWxWwXi3MU0OJr89yrieNZsYjgnxFaVGBkSE2Jm7U4wTF+7/c7nb
         aA5I8twP7C2k71xOnOeTb2OHy2wN8YN77gA5B9YbkhPtToj75mDopiGfy5NBbxfWJDLg
         RM9BJoxnFIyiMKuor9PNQCBEFWuZ/JfIuo3hX2Oop+TnB8HRPDw1WHUDZ1fQibdLOScS
         LZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774288685; x=1774893485;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAFVmIYqCpTk7YHQuUKCiaGw6d7SaBhhkzvznBNGhns=;
        b=R5a1yftftOU6D4UD/+YkvTEh5pcBnrjTxiZHBgvUdVOoCjuA+2Oqmv+lGnXzzZVwLB
         hHqhvgJbd1251kCyY6e77te0Ob7is6MUBT8PW5+6CYmZ6mw99ljMBEXLNOLenJ3Q+Ph2
         BAHzweG++WFs9pmsr+0krljd4ViW1hZWB5cDPtQb2LVfeWaJ+EMC0nHerYTA7f7e7yzQ
         Qz8OSaoGOlj3AyLWu2S6bnY58TJ6/pi62l6xzg5E3ALzUr22hs+2nf0LxfEqGttTWIA2
         KOIrvJfF+ccoI34gueevsPGCYdisB4Fff/PJYZ3sPSxxqm8DwKjBeO1LugPPpceS1Xj4
         1JvQ==
X-Gm-Message-State: AOJu0Yzv7Ch6Dz1y0Zd7CpsQMJBOnctAs3a8cYa7rm7UR9Vnli3kManN
	C3178H7GL56iZ39Sdbam96A2cHfwU+N3a8c8vhD6AdhiK7Qlp3eOKRVt
X-Gm-Gg: ATEYQzxJ4YTwTBKE3XGr2SjomkUcKqn6kaFplHjxYpKWA35qLe3zgGO/J324SClXLLg
	AUw/seurX0PCkaekUReYR20/PBAtxNS4aqSzfopntI8KE5eXP8ZX30FEwXQwk8xzqJdZjj28q2u
	7EsgCEKIOj/yj8oDBi68ig3TsFghR2NLL8Jlmuy7ZtZ95Cw6Gd4kW775phAwJrsWMRqV++ycoxi
	YETuB86Zn+Qsg8DLVvhq9PRNQncG/jalY4GdDKLVfuT2FZlfYT+weQ+zfz2NcfuAzcJhQcRaMZX
	QO1zwqkdibS1ELSwfUSsWfJtJy52kHPPQT41sZbAnyyhlQylts1KUt8xvDeR4Ix0B7RF89ZpBY5
	AiPLbGGrpNveiqGDKotcso2yJIJURrWk4Hnijj/1i3d6BaDExGBCXngP9iZctOLCd1bDm2UEBMT
	TnvPj0rBXjyuhkH3vv7ps6jgxFE95RTXCr+uuI
X-Received: by 2002:a17:903:2acc:b0:2ae:7f85:33d1 with SMTP id d9443c01a7336-2b0a4cd49e4mr4562165ad.0.1774288684737;
        Mon, 23 Mar 2026 10:58:04 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835551c3sm113415065ad.35.2026.03.23.10.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 10:58:04 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Tue, 24 Mar 2026 01:57:59 +0800
Subject: [PATCH] PCI: aspeed: Fix IRQ domain leak on platform_get_irq()
 failure
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
Message-Id: <20260324-aspeed-v1-1-354181624c00@gmail.com>
X-B4-Tracking: v=1; b=H4sIACZ/wWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyMT3cTigtTUFN0kA1MTUxNLM8MUc1MloOKCotS0zAqwQdGxtbUAgHK
 gQ1gAAAA=
X-Change-ID: 20260324-aspeed-b05454961d75
To: Jacky Chou <jacky_chou@aspeedtech.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-aspeed@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774288681; l=1574;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=cYrcg8cZ1OOgmV+TAbZ97fcCPC0PWmH/iybgc6SDMxs=;
 b=l+RPKAQMkKB3prPtTq61GiYDOiTZZEVvZpdPRmil5aMf0ygzxdGhIKpTojXIdqk8Guifwxe3Y
 UOj7efLJOKnAPRYwxbJvxbBY6Iz1Z6VcYRmZbAzVLfAw5weD9l6RPeg
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The aspeed_pcie_probe() function calls aspeed_pcie_init_irq_domain()
which allocates pcie->intx_domain and initializes MSI. However, if
platform_get_irq() fails afterwards, the cleanup action was not yet
registered via devm_add_action_or_reset(), causing the IRQ domain
resources to leak.

Fix this by registering the devm cleanup action immediately after
aspeed_pcie_init_irq_domain() succeeds, before calling
platform_get_irq(). This ensures proper cleanup on any subsequent
failure.

Fixes: 9aa0cb68fcc1 ("PCI: aspeed: Add ASPEED PCIe RC driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/pci/controller/pcie-aspeed.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-aspeed.c b/drivers/pci/controller/pcie-aspeed.c
index 3e1a39d1e648..6acfae7d026e 100644
--- a/drivers/pci/controller/pcie-aspeed.c
+++ b/drivers/pci/controller/pcie-aspeed.c
@@ -1052,14 +1052,14 @@ static int aspeed_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
 	ret = devm_add_action_or_reset(dev, aspeed_pcie_irq_domain_free, pcie);
 	if (ret)
 		return ret;
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
 	ret = devm_request_irq(dev, irq, aspeed_pcie_intr_handler, IRQF_SHARED,
 			       dev_name(dev), pcie);
 	if (ret)

---
base-commit: 785f0eb2f85decbe7c1ef9ae922931f0194ffc2e
change-id: 20260324-aspeed-b05454961d75

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>


