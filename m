Return-Path: <linux-aspeed+bounces-2551-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF911CCD1AA
	for <linux-aspeed@archiver.kernel.org>; Tue, 21 Oct 2025 22:05:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4crmZr29LTz2yvk;
	Wed, 22 Oct 2025 09:05:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761016556;
	cv=none; b=K4b89xfH7kLeOlCFXRY7c0vDnS9MVYqReBhhIgMVrz177DhmocHXI0nC1/4EPTtOElBYFHw8phTkM0Y3kDoNzAvHdkczB8euMfrN/LVLumkfLUr7IdZFYodu/pNAvLGdkqhPMzXYZJQeW0OdEVKp1Dz96mKJ+/CvsJrkSaTk+qw0H1w4WkbyVtJZzW9EyMhHR3supkbTJcNgE3uco5zRbYbaWnBEe60oxzIzvobICP+4QU/OjNC0mImPel6kge/4JUaLebkzypx9qxMrPo/Gx+EYAqMy0ReiXV4F89yp8YzACM7DKOPKr5bG+e/c/hCHdLC/30x29oJWhf7Gtv2oTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761016556; c=relaxed/relaxed;
	bh=MIc5Jk6uXrpT5vKhUN3R3BidtAKxdUPzX/dU/naleU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Xpf714zNFDQP6w8NVCGstWOPUhNjERNf3/gUvFwPGqaA0j8egpE8Iay4OEJakFM8LkxoOuYHS8yeKIRa6uM120Up27tKIcZTPlJma8g8GOc+OJHV+yQsu8pRLh610eh6P2SyX8fLFvw+QDt6/sqJ0n9ntzsGcKx/ZxQ62g+aQty5g9OHUYB33vYtQiCpWntTFpvWK+JkFNWIKgfwJLtqTtNF+6ZJ0/pvdDjD5zOY7QvbyeJq6DZgDLceV/bbEhufn6wgHO0b/vTzoqDWHYufbPRgrBkGnSqahhgotMYcojVLLpL/6WpYSRquEJV6kQ0Ralw3jJSaF4tdMB+Dr0BoxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Y+loLgrn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Y+loLgrn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4crHVz0MDGz2yhD
	for <linux-aspeed@lists.ozlabs.org>; Tue, 21 Oct 2025 14:15:54 +1100 (AEDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-b5515eaefceso4197276a12.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 20 Oct 2025 20:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761016551; x=1761621351; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MIc5Jk6uXrpT5vKhUN3R3BidtAKxdUPzX/dU/naleU8=;
        b=Y+loLgrn1/fFC5jq8w+DCAIOWvBybghDiN1GRZfKkvY8xISBENGHblHbGg41ya1Wy4
         Oxl7hNs4eEhoaUn+v+OeB69wpsvd32OVPtUHH4rFoawaRlz4SN2ip77De1QRYBiT2yZg
         WbWlApQVk0NwrRTcgmX0AmcnGvL4Z8L1ThgihHUVUjtTTICWN82b+EJXpstyZgjhnJXd
         5a8gmdreWt2g+G3BP4ygLSGuBChiSUtygir5s9hq7IRO8sm1WfKTR5CqeSk8ly1GJakJ
         63SJuB+g39yGtRURJZqYeQKQPryWYb37TMHrYFkUpUkwwMbjuhHTWrbVE6VmP8+3udhZ
         tCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761016551; x=1761621351;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIc5Jk6uXrpT5vKhUN3R3BidtAKxdUPzX/dU/naleU8=;
        b=OSfbSVPw/BVrxmrukMaND5gs5Rq7CRwBFpRj1bqLDwhjWajf08x0mJPjkJMvTY1BEh
         9Xkt3K7jRuOwNFeqhoyMwdMcAeLH+Mz9JK1kCV95xQvJxCjCCYIp9N00v4UYUgY7nxwx
         QV0lqX4NeY5WfEOypaEp2GUiT95nyHgBNhny93/IGt8T2VMTY2wQd4SZCf3U5Ld4uVax
         Vch7NhoRdehyoTUo4ZRNDMD3LiAQ+MsUF6IR13ux9EziL2tvkjlD4A+uenDtLr5uJZJF
         VoUUmJYIXJ8HDK2H4l6ThxojGKRLyoYhuTyfx67kxbCf38sIlTL4olOkU0A6G+ziTLnv
         sCpg==
X-Forwarded-Encrypted: i=1; AJvYcCVHiluYzh3gbp0U0KjcbS+a7L2WAOrE1y/4YY6ITcc+5dr4Anq/5ZC+bl16bn+G1Ln4zoO7gsZ9wpC9pNQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxIRCRbzeBIqtITuOq5LENB4/aJH/fnRX9zJGlIrBnRVW2qO2zY
	x57MV7PAyMbw2+07zXWnDsJyLd8iXCH+8HRSigxlVi0cvD6mvvfwCnc6
X-Gm-Gg: ASbGncvT9O8mJ1zlPW0fcIT5+xMXtvL90pRLjm/mlM7Gj8RkKSMnG2bnpvluAzwj+iT
	9/IzoYqNy7MdkuInDNnNgdhzchjiStq4ypJAkYdbiYYuaaAyL0G+jB/AJ3La/xxJRa25MEnJ3Gi
	j0l7dT5XGyYRtrNrOFArvLntHnSKsbGX/HrlJLupoCVk2XAlNv1ezhJJ0yLORufagAt+/TO3tTU
	rYLRy6bFvV5spUBOiPsTDjzBfikufV+UcK3oWmLWsXYsZOQJnBwJI0pApqdNHXUWWfHjiwNqC3O
	Yeggv+jFrxlYNv/PI+qhjQq3xythITBB1J1b3Hb+uokkilW/PK9+PVDAVhcEWhB2W1wjLpY0Rm9
	YgfqPVjnysjABYeVXBoAoSFyn1TyArv7wMFzIvPulODLF8WBtaiEebVNjcwpe+LTQ7cJjxQTzBt
	wqpssDwzHsTEi4Q4hvBR/2HST90jdDq8EVS90Z
X-Google-Smtp-Source: AGHT+IHvc2OdIns7Dhqd5TV4LyvC/HJfGjCUatzoXh06HQxZAcairq7EJA2klU28lcwGsK1CQQDx2g==
X-Received: by 2002:a17:903:2b0d:b0:272:f9c3:31f7 with SMTP id d9443c01a7336-290cbe2ae84mr56298125ad.50.1761016551034;
        Mon, 20 Oct 2025 20:15:51 -0700 (PDT)
Received: from [172.17.0.2] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fcc2b1sm94889765ad.27.2025.10.20.20.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 20:15:50 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
Date: Tue, 21 Oct 2025 11:15:39 +0800
Subject: [PATCH] ARM: dts: aspeed: clemente: Add EEPROMs for boot and data
 drive FRUs
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
Message-Id: <20251021-leo-dts-add-nvme-eeprom-v1-1-33166b3665b4@gmail.com>
X-B4-Tracking: v=1; b=H4sIANr69mgC/x3MQQqEMBAF0atIr21IZ3REryIuxHy1YUwkERkQ7
 25w+RZVFyVERaKuuCji1KTBZ0hZ0LSOfgGryyZrbC3GCv8Q2B2JR+fYnxsY2GPY+CPfqpG2bid
 rKNd7xKz/99wP9/0A40cKRWkAAAA=
X-Change-ID: 20251021-leo-dts-add-nvme-eeprom-316471959c20
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 george.kw.lee@fii-foxconn.com, bruce.jy.hung@fii-foxconn.com, 
 leo.jt.wang@fii-foxconn.com, Leo Wang <leo.jt.wang@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761016548; l=2272;
 i=leo.jt.wang@gmail.com; s=20250618; h=from:subject:message-id;
 bh=FozCj5Qtilnm6MTFQqUJJBi0+f5aDzs/7epoDnQr8Rw=;
 b=8BInr5iA6wBDcAL4sY8DnyKW4muBdm9myjKyhrNgz4zvC7PgZByz+aciemOqaw2l3lP+Dk17F
 WiRuYEfnT9MAdWDDJm8CfcmcWioWtAmA94gNx57lZN4uJoHCmtiSswe
X-Developer-Key: i=leo.jt.wang@gmail.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

Add EEPROM devices on the I2C buses used for the boot and data NVMe
drives. These EEPROMs store FRU information for each drive, allowing
the BMC to identify.

Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-clemente.dts    | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
index 450446913e36b1418fab901cde44280468990c7a..885c50a7d66593dfa8493d2d031700174b452382 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
@@ -311,6 +311,12 @@ i2c0mux0ch1mux0ch0: i2c@0 {
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <0>;
+
+					// HDD NVMe SSD FRU 0
+					eeprom@53 {
+						compatible = "atmel,24c02";
+						reg = <0x53>;
+					};
 				};
 
 				i2c0mux0ch1mux0ch1: i2c@1 {
@@ -323,6 +329,12 @@ i2c0mux0ch1mux0ch2: i2c@2 {
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <2>;
+
+					// HDD NVMe SSD FRU 1
+					eeprom@53 {
+						compatible = "atmel,24c02";
+						reg = <0x53>;
+					};
 				};
 
 				i2c0mux0ch1mux0ch3: i2c@3 {
@@ -493,6 +505,12 @@ i2c0mux3ch1mux0ch0: i2c@0 {
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <0>;
+
+					// HDD NVMe SSD FRU 2
+					eeprom@53 {
+						compatible = "atmel,24c02";
+						reg = <0x53>;
+					};
 				};
 
 				i2c0mux3ch1mux0ch1: i2c@1 {
@@ -505,6 +523,12 @@ i2c0mux3ch1mux0ch2: i2c@2 {
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <2>;
+
+					// HDD NVMe SSD FRU 3
+					eeprom@53 {
+						compatible = "atmel,24c02";
+						reg = <0x53>;
+					};
 				};
 
 				i2c0mux3ch1mux0ch3: i2c@3 {
@@ -619,6 +643,12 @@ i2c0mux5ch1: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+
+			// BOOT DRIVE FRU
+			eeprom@53 {
+				compatible = "atmel,24c02";
+				reg = <0x53>;
+			};
 		};
 
 		i2c0mux5ch2: i2c@2 {

---
base-commit: 6953afcd81a2cc73784e3dd23faa0a1aaf97441a
change-id: 20251021-leo-dts-add-nvme-eeprom-316471959c20

Best regards,
-- 
Leo Wang <leo.jt.wang@gmail.com>


