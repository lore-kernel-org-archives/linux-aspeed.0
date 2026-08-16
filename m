Return-Path: <linux-aspeed+bounces-4739-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEAAC5DF74
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Aug 2026 00:41:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNYtM1zMyz2yFW;
	Mon, 17 Aug 2026 10:41:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786900622;
	cv=none; b=f9rFcnRUImPAxucy/hZpx4pn9AjDXkMi1QPT5NPkk6uwsjVXg/8x5KYcBSDH7AzF66CC/dQ7Vb7X/ZlABL2St6TSd7gENdjJ1jFztCUdaTg+rkMf6ikPGWhVYxxJ09VxQ5mzxgXCw0sGMvgLgqTPfCtULFbbB1v596J/c360T1ZLFWQuoDMKWzWOiRxSfDqBM2g8GVm03KpqWwgdXkBONBnDT3CQd5AtPBDiBrXvIL7t5QFqmk0gykWYxyB6gtKOcpXvQS73ncXAbIHI/939M6e7VZUe9dbmu9c+wGj46XzitYHsPj5EsxZBK00qOE5A0k7pWy3Rx3gFszSDWrChWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786900622; c=relaxed/relaxed;
	bh=jqHlndu2mP4JOXXcMYq7yqkvIBuKIHfSguke33kVois=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CqpijmJbDM9pSuyYP94JdIhCVB7/+t+HqdWKdI8dd1ELgTGuXAUAWacwF4DBQLWvTVEznHIKDs+cRFPzFcfP2gQ/EfW/VjCn4Se3CVFBvWr8TND7/5JDKQ0KEqr+h+Vcf+ApGjHE+a+95/tk80w7NJvN7JYnAL1I7+yA9iT71wwh+PR4+vy0wUigXCuLNYrBjsJoYSkPizg18U35n7PD425tomNYICAY8tPfeiD7bm4aWKP1liMP3gQz6goMyyehdPFhXdRC4j1LzGi/7fIhQPdRyyCwENgJjJtgNuoUjZ1bzhdm3qnaH7/y1w3y+KzvMay0yHz12d4eKSrDB+rUMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eiwpM9sQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=dragonliu2018@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eiwpM9sQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=dragonliu2018@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hNN1S3bydz2xtt
	for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Aug 2026 03:16:59 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so2171428a91.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 16 Aug 2026 10:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786900617; x=1787505417; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jqHlndu2mP4JOXXcMYq7yqkvIBuKIHfSguke33kVois=;
        b=eiwpM9sQ0oEyGze4n74bUBoH5KXEimJgNTigMCGnsHsMv3NpWReKt7DTlf+yxX3m6K
         pc6Uw4fK7aiAY8E8Ge6/zO5mmo+iWaU62wKsg4RLNbtzKBMSF8sXFECbQ3ZvLFP9lqWc
         J02t7HdAnI5Ly0rauoeSgugMN7jdchKQoH0rf2lqzC2+X8iK08yHxcNtMDkEeWLwEzw9
         xsnht06IABFUqm3/7jLC1QFCCEz7fL2kXBW/eZHVFYe2Xrqa0oITNrfyPBKV0zOq98H3
         mClfEmwqpFl3qzwy04+o7Q4cDy1D7vFRVyXex85OTtI07mHHcn3zrJ1ud2vlQ7KoDQ9c
         2+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786900617; x=1787505417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jqHlndu2mP4JOXXcMYq7yqkvIBuKIHfSguke33kVois=;
        b=q3qyZePFSYIjhNFbhnB2Tz0zMH+bWAkQDkoZ60A7mv3Kqz8///Yn4vOjHLl0VeKldA
         xkA1AkHBw3JobNp/CmmFfxEOXVIvnsxBoPYqE4fehmp1SWgyneHMF+sa0ghHUhwebNjb
         bv+cGKfvghez1IcyRfohkqWRi+hqTHZVIb1ExustgptFc5PPidcbc46akhZET8SySKAf
         JhCeeNJAHp7qYiOhL0WUzYbXAS/NUNdgOZiusm7lu+vaHW1j4dlslfW4R36u1puFCbF2
         aW4O+anSKqZONxEBLgbMA4iR/CjAuqT1klanPiDHOVmZQvyGZvXazXvvpYEGsBEX02cU
         zxyA==
X-Forwarded-Encrypted: i=1; AHgh+RqzXNEamarcXSSKZhEb1Z67Jspxnefb0fI54FA9v13jCLJNaeW9oNNTNSSMpz3ygJnHN05Nje7lJupWLjw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyIW4SLRRKdLQrCN1jxCe9lSx06f6bC5Z4QcUGgIjYFF5ETeSh7
	wjpVmsOisUHv/+eoUSePYJv1l1sDoaAdL8hRFyeygVCOPFXm8JjEnmnD
X-Gm-Gg: AR+sD13pTJlIVHl+G5vNcMMLLCQesb0NJj6LyDFtQ+2G5NmUoh0mMCqp/G4qEyygA2C
	uGFjMYN3EWsgREbtZfuldyiHPBMRu1ELAg+DF+cLG+AnmNMYn0vqlde23obyu7YkswTEkOb02Ao
	cKudYj0HLW55/6zCW3mnXVMblqoS08HXjSQWlKibFiKzG4XwCgMFXUDssJB55ULJbDkrK7Q0xJq
	iHwhSCvS27fhW7dXCoiuB61hmwhGWqqhFU+wL1IrBfUZG49LyMoVShC+leqYEQsMtY0RIMseRu4
	wHgfpcroEaNRV7JVpj0htRPp/SvYyeHx7BZSrYNirTb8rLjazr35uFqsY2gGXrXl9/qwYE3WBbF
	TfY/wzFPr7uuKah5erYkhoLQkDx97tM4NCuVtrJaGGpSlsKtQMB/EK/MHoq4E7+VHfugVv5GkS7
	uZw7iot9YEEKtE/71+ar7n5v/b9j8wLSVwosIM7l/qdZ0Cg2tqNuF4LkbHnHHxgKbQubXEOYTXF
	bO+WcK5+kXmDeFdmYK4iBm+O3Y=
X-Received: by 2002:a17:90b:528a:b0:38e:5ac1:9517 with SMTP id 98e67ed59e1d1-3933b7c3696mr20611825a91.3.1786900616817;
        Sun, 16 Aug 2026 10:16:56 -0700 (PDT)
Received: from localhost.localdomain ([240a:4280:4800:1470:95d0:2f3e:656d:65de])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39339d00eafsm4607627a91.1.2026.08.16.10.16.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 16 Aug 2026 10:16:54 -0700 (PDT)
From: Liu Zhenlong <dragonliu2018@gmail.com>
To: linux-pci@vger.kernel.org
Cc: jacky_chou@aspeedtech.com,
	mani@kernel.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Liu Zhenlong <dragonliu2018@gmail.com>
Subject: [PATCH] PCI: aspeed: fix clk and phy leak in aspeed_pcie_port_init error paths
Date: Mon, 17 Aug 2026 01:16:33 +0800
Message-ID: <20260816171633.15025-1-dragonliu2018@gmail.com>
X-Mailer: git-send-email 2.55.0
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
Content-Transfer-Encoding: 8bit

aspeed_pcie_port_init() calls clk_prepare_enable() to enable the port
clock, but if phy_init() or phy_set_mode_ext() fails afterwards, the
function returns without calling clk_disable_unprepare(), leaking the
clock reference on every probe failure.  Additionally, when
phy_set_mode_ext() fails, phy_init() has already succeeded, so
phy_exit() is also missing, leaking the phy reference.

Add the matching clk_disable_unprepare() to both error paths, and
phy_exit() to the phy_set_mode_ext() failure path, mirroring the
cleanup pattern in pci-aardvark.

Compile-tested with gcc on arm64 defconfig using COMPILE_TEST; no
hardware available for runtime testing.

Fixes: 9aa0cb68fcc1 ("PCI: aspeed: Add ASPEED PCIe RC driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>
---
 drivers/pci/controller/pcie-aspeed.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-aspeed.c b/drivers/pci/controller/pcie-aspeed.c
index 9aa9e14c6148..1fd663ea3bf8 100644
--- a/drivers/pci/controller/pcie-aspeed.c
+++ b/drivers/pci/controller/pcie-aspeed.c
@@ -761,16 +761,21 @@ static int aspeed_pcie_port_init(struct aspeed_pcie_port *port)
 				     port->slot);
 
 	ret = phy_init(port->phy);
-	if (ret)
+	if (ret) {
+		clk_disable_unprepare(port->clk);
 		return dev_err_probe(dev, ret,
 				     "failed to init phy pcie for slot (%d)\n",
 				     port->slot);
+	}
 
 	ret = phy_set_mode_ext(port->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
-	if (ret)
+	if (ret) {
+		phy_exit(port->phy);
+		clk_disable_unprepare(port->clk);
 		return dev_err_probe(dev, ret,
 				     "failed to set phy mode for slot (%d)\n",
 				     port->slot);
+	}
 
 	reset_control_deassert(port->perst);
 	msleep(PCIE_RESET_CONFIG_WAIT_MS);
-- 
2.55.0


