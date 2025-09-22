Return-Path: <linux-aspeed+bounces-2326-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C93CAC592
	for <linux-aspeed@archiver.kernel.org>; Mon, 22 Sep 2025 23:43:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cW07K1Prkz3cBW;
	Tue, 23 Sep 2025 09:43:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758524591;
	cv=none; b=i4VS5UDQBi07ybd/IAVOCZr92Cn3HFwrtop4a1+E0fv8NvOF9ot+8x1VRWObEeZ3DMdmjEuYOTCdIPybR6PYNTLU0dixcKmTjXvPyNNXFzX/IEbLwI+PLrJhx2BvvOd/fBPEOe7c5dp/o4Hd0n18Jb/vwc4ACUHG9nVCuFWjzYevPomgl8EGiBb74Ghwid/Yh4Y6OJjg/87VO6DFZ3r/LGAKbJjnU0vHiuK1A531E9yR2aPDZDX+6lTVwq0krw7ovuJ7/0JrHjeUzr2IZTf23NGD3Nub2AbN5YUgofQKz/Ji0T88TauQozbNWaEXYJLL4We5rS0vO/76CtNaGfwW+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758524591; c=relaxed/relaxed;
	bh=4VdrnFXMa9rFd83Zher/BcNQQzlodlm+IkoVXej7FCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OaHmnnpoPQKDg1JiE1Qn3VlD4xen/gmhSbOtohHoKXYHLiCZikvbPUVfQDgG12Oc6BWSoyxLyfxY4iVuzOsG13imwN6ut695ohqThrtYYMIbhJffqOuYVbKXTA2V0VOGw2z3ddlnMKp2PewAQot5c2wXbH78l1MVytKsbYNO0t1/2uDZ4AAh0vhGpzr70jH5dnxHptvSo1tACHIw0D9gZ71Kccu99yKffS+uqk+SjQvcaD/sFROufMg3Uk7YNh/J6YtA00QeEOMjMR2fE/wXvU1kOsFaGIEJJ+LsByIlky//uMuUyw6q3OVcLaDb5BApHDM83iP+26eovAlG/52jMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JZMmU25l; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JZMmU25l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVYwb1yZrz2xck
	for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Sep 2025 17:03:10 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so3965970b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Sep 2025 00:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758524589; x=1759129389; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4VdrnFXMa9rFd83Zher/BcNQQzlodlm+IkoVXej7FCs=;
        b=JZMmU25lUnH0npR4t8CK/PUc3O8Stv7qGo07q9eB8MK0FrGCf03JyeSMHOrGcyvYif
         E2ojeugTA5/aLkLQBS+jw8WPL2MU8L05k2LvkknvN9CpaENC2rQe/HgeUhtFigIgeKon
         I+7kSCcJyOlyVnzA2ePI6o/QlRv10yHkBFKYZbrEyica22d5HK3MP3EE+CX5DKgmFEHs
         c1PrMYqa59rGJLbbBHO25AmYwnwgr+sVh10d62cP5rBRYz/MGAkw3+azbmKqOMmH7qg5
         PtmIprvuw6k+1SjjD7+UkEYkXs7o1kZMkVHtq/UXQ2N1N8YawAmiOveyDtLyNnFNF6BD
         k/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758524589; x=1759129389;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4VdrnFXMa9rFd83Zher/BcNQQzlodlm+IkoVXej7FCs=;
        b=W0I+n3U4mI8okASOysD7vi4YRLONWSjJDQietZte2Jp9Jv7Uey7GqTZA3wEDIUJl2S
         YLpJumnpqd3Xdcjgerpd4pz0nf4Uvq2Y5Hrzb2L+/nMo4BGxMAVyIDepjwCEcmfAW70b
         OWqodQfbpT5dm5ZM9Xecjf+8cvXEZlRMRSMUufjuunxLZMozjtt0w7XZhxxTPk0vx93c
         7vh5GhYh0eImRZ5oPWSASR3Ag2OcAdfzHqfWQ/vTWzeRDv0ik6ekUZeFt8uTFEz/vLGz
         9brVKn2H0vBH8KHHKO5kufssPnHIMTktSkrnfA/8bMhBc8pzDg22r6IGTNPdB5oNDheJ
         uhJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC85xbRCAhLzfkrv2nmT8h8gAZKo/5bg0Vm7IkCq5WMZqz8BnvuWz5q+vWZCqHCWWqNP2aIAWrvG0Ekiw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzW1H8AbvHYuEZKw7mxrQAgtzdBk5eUgguy3yvG5lhHDaitkn0a
	Dw+nSbwM4eZGVDn/bAU2DY2e8Q50d4gpannUBrnfJABFKucLDtAdqVoy
X-Gm-Gg: ASbGncuq+mu5nSz3/3TshMRE7YOPbE823gViU/8hEF+lnZSvLcYHg4kRMMnFupf1DjF
	2SRXoIGbZVuvUD3Gm7wto17nqda2nsiFGuVBjzCwHMpGP8+PyXa0fFWVqqo8Gr8rE4J/0F3mHoW
	/9OYYDNTwLDBi6hwgJ6+BkU+vF6oFyOM8ieaXSKV2skjAtf6EyeFTcYxLOWS0AjKBkt0MQGnBzS
	IPT0sFXkSRD+cWGg7aLcm2cy7VoiTpd8n46nUtOYqQqMw9vRWAFFKFJwyBL1Y4g1GeD2v+2/tkE
	fATNCJ29qt7Y/bZZ1lUk2XTEgXPy3ael5GvUVJhozTOXXU4sSXS9FJqHa1Il+72B50qrkUXDZcu
	Vf/zubhGvKrX7fc7TFWzEl3guoMX6hjf8G98Ndo0dI5ToK3URZZFWH0BCW/DNBe2D9ic=
X-Google-Smtp-Source: AGHT+IGJ48A08lAcVKcYdk0WkcJU/k9veu86ugQxlnRCGNKMTcl5D3T3DnGhbnyIKjGQKizhhH8t5A==
X-Received: by 2002:a17:903:2f4c:b0:263:d6b5:fbe1 with SMTP id d9443c01a7336-269ba56738bmr118340355ad.55.1758524589057;
        Mon, 22 Sep 2025 00:03:09 -0700 (PDT)
Received: from [172.17.0.3] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-270cdb02c3bsm61149115ad.102.2025.09.22.00.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 00:03:08 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Date: Mon, 22 Sep 2025 15:02:48 +0800
Subject: [PATCH v2] ARM: dts: aspeed: clemente: add MCTP over I2C support
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
Message-Id: <20250922-leo-dts-transceiver-v2-1-d2dc0e24a70b@fii-foxconn.com>
X-B4-Tracking: v=1; b=H4sIAJf00GgC/32NTQrDIBBGrxJm3Sn+IKRd9R4lC9FJMpBoUZGW4
 N1rc4Au34PvfQdkSkwZ7sMBiSpnjqGDugzgVhsWQvadQQllxE2OuFFEXzKWZEN2xJUSkndaknZ
 K2hn68pVo5vdZfU6dV84lps95UuXP/u9ViRI1KTMKrUyvP5bd8nZ1cYeptfYFSinqOrYAAAA=
X-Change-ID: 20250918-leo-dts-transceiver-edc31e3c21af
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 george.kw.lee@fii-foxconn.com, bruce.jy.hung@fii-foxconn.com, 
 leo.jt.wang@fii-foxconn.com, Leo Wang <leo.jt.wang@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758524586; l=2794;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=9m5R4VJWufe7k7yurqqw3z2y+D8AnXNo6e7S0rTybvc=;
 b=H587RMaWwa8qjdxlMqKskZgP2x92LSHN4XC0VLs+x1k0fF8sSLgQ/oghPLxbeWH2ZTr3udvki
 ykREjgsCdz8A2JTncdm266pra8yLsRJBoZ5qb8m1GYIjQptIuBJiPlC
X-Developer-Key: i=leo.jt.wang@fii-foxconn.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

From: Leo Wang <leo.jt.wang@gmail.com>

Enable MCTP communication on the Meta Clemente BMC board:

- Add an MCTP I2C controller node at address 0x10 on I2C0
- Mark selected I2C mux channels as MCTP controllers
- Remove unused "i2c-mux-idle-disconnect" properties

This allows MCTP devices to be discovered and used for
management communication on the Clemente platform.

Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
---
Please consider the patch "[PATCH v1 1/1] ARM: dts: aspeed: clemente: add MCTP over I2C support"
withdrawn.

After further review we determined that enabling MCTP in the Clemente device-tree is not
required; the affected devices are managed through other mechanisms and adding MCTP nodes
would be unnecessary. To avoid confusion and noise, please ignore the previous patch.

Original patch message-id: <20250918-leo-dts-transceiver-v1-1-3e2580325edc@gmail.com>
---
Changes in v2:
- Withdraw patch; no functional changes
- Link to v1: https://lore.kernel.org/r/20250918-leo-dts-transceiver-v1-1-3e2580325edc@gmail.com
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
index a614f947dafc9a6628c3f3d45b62ff3ca9d2b618..a2f0ed6e7bbefbdcec33f7ddebdf2de62adec164 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
@@ -269,18 +269,23 @@ &gpio1 {
 
 &i2c0 {
 	status = "okay";
+	multi-master;
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
 
 	i2c-mux@71 {
 		compatible = "nxp,pca9546";
 		reg = <0x71>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
 
 		i2c0mux0ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			mctp-controller;
 		};
 
 		i2c0mux0ch1: i2c@1 {
@@ -332,6 +337,7 @@ i2c0mux0ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+			mctp-controller;
 		};
 
 		i2c0mux0ch3: i2c@3 {
@@ -457,12 +463,12 @@ i2c-mux@75 {
 		reg = <0x75>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
 
 		i2c0mux3ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			mctp-controller;
 		};
 
 		i2c0mux3ch1: i2c@1 {
@@ -514,6 +520,7 @@ i2c0mux3ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+			mctp-controller;
 		};
 
 		i2c0mux3ch3: i2c@3 {

---
base-commit: 1937f781fe7fcde26e537e74dfc6097fc08fc9bb
change-id: 20250918-leo-dts-transceiver-edc31e3c21af

Best regards,
-- 
Leo Wang <leo.jt.wang@fii-foxconn.com>


