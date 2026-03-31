Return-Path: <linux-aspeed+bounces-3820-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6812B109B46D
	for <linux-aspeed@archiver.kernel.org>; Tue, 31 Mar 2026 14:18:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flVZm6ZLnz2ybR;
	Wed, 01 Apr 2026 01:18:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b12d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774966688;
	cv=none; b=d9dbHVaCYtU82UucC6Gpknfr66w96M//dzgOP8DXa5wf0+a+DpuNtwzbJq9OPufLGuVYH5Ja426ghEKkpW+J5uBIOwr8jKPV1GPY5ysyBYPMiyHNYPpDXBspMcVqi4Ubx97uDODeJk1/ZPPh57z1dO1ucyROcc+T0YJNm2YWKMsTUKmcjqIdlQqaChOyH2yAu4oTS5/BvtXI9qZfXuz5X+EiBHWV1HZbQf4zTpWYIAQo2pn+LOt9YyH7vde1qMDCfeMU0AIuhpRfffjO4Un12bE9Y/3T3qmesqpwBLgnote45RfeTSELtNKafFb1H44Iae/pLhnC/iYxsRrrSQTekA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774966688; c=relaxed/relaxed;
	bh=Wmozg0m3DQsYpGD8orkO2ipP4TyyaAJHZKLp0sbHtfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Mn8Dq+N/KfrtQbJB2+NsP4/ewmb7w8phKKCoGbrooLjP7QPJpyeZ9Hd5JTvva5lB+1aAXVVY2aYrwlnVSqsRuYedraXhgv9SolioVvqvWKBz9YgbdKbYL+zBkG3dvelz42Ntzr19CBe/KzPXOBWc3NbhVjNSn3+ex0BErLNDnvwjG0EcbqTTPWpHs1VBVBlnh257+kX9yOem0I1M8q0pSyPArOIJwgdHKUtGkCLjw4E6nMr7sYS/DhqRhGImRY4TDxfvnDu9FCdK2C9NF28AdExLfEZr5f01ER9wE024jsU03ICKoj4//xeycWw2K1pit52SC73yir6L9qeMNHAlFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FidLX4DP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12d; helo=mail-yx1-xb12d.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FidLX4DP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12d; helo=mail-yx1-xb12d.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com [IPv6:2607:f8b0:4864:20::b12d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flVZm0mlrz2xSb
	for <linux-aspeed@lists.ozlabs.org>; Wed, 01 Apr 2026 01:18:08 +1100 (AEDT)
Received: by mail-yx1-xb12d.google.com with SMTP id 956f58d0204a3-6500040f172so8188106d50.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 31 Mar 2026 07:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774966685; x=1775571485; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wmozg0m3DQsYpGD8orkO2ipP4TyyaAJHZKLp0sbHtfk=;
        b=FidLX4DPShLCp8u9EaadedywqOShtSf6ODKAzRqa/BerX9YXLXAclIBoZ7XlQrYRQS
         IzbzwYZucYGdy+5Jy2/zEqRQon/chLmpvEpmZJ3Joe12wubjMavaSJx3M0mf8MspT4yF
         LK/TKCov96SsPNMiabNZGcuclZykVWaa8SrT4IqyT9HHyZUzk4kPDctZmYExXkt9KcJr
         LY+Sa7r/TMd3JO54O/K30VpM4ykmoyB61MygkpaF1mON+/2PRQh2deL/qPocr20LYKQ0
         9MctSAhE1/e0IFBQk+pvXmsUzINoyVuD7Kp5vspiCRnUG35A+i4gpfHEycoYFQVqnlPP
         jb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774966685; x=1775571485;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wmozg0m3DQsYpGD8orkO2ipP4TyyaAJHZKLp0sbHtfk=;
        b=lYErhdVqEhI4KFYam2Vr20zBsWjypARHBCuAvcCgCdmVaI4o+IArmPOI5yfvmuP6vs
         s8cCs/HR+bSM0dY/0mhmnFLo1g4EVGAGXsAc/nx23xZyIg0zJkl1t5Laq4QKNKUJDavi
         sJJIxg19jyk7vxwllyObzZfz8C9TePRhBxlnSTU14n2vEZpvSFPU8lxClS4Ngu3SSnDi
         wYuVHPrZIHnYuBefFGhebrfF7yqY+npRmHXbE5EI6Cb5czKIFbnR/FNvoVdC3xkqDM1f
         dv0GEl/6hBZH7L1VTiLKuon3it0FnuUWjRzeCIZyN/yYc13LI0OXewt5Hol3nez1gPsY
         rrDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0+j2oY733M4OpftPhOvzVmJK9+Ee6+pmNUODQYFtxd0hoLm9ccnDbS9lHDE1R2VXJB14OF9hrtXzjHCw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwoCk8qsFyT7pQVvdG8AYHBEqaUyp2/xFEFsVF9QygOm1lNB/FH
	j1hJHwtvevlgd30jWcidjY6AhQQhFmCou3QBdbyGfAgx1laegyuJdQN6k/wytctZ
X-Gm-Gg: ATEYQzzPT5Nj00y62ONbMCa6lgwmKIvav6Mo2RVm3/poUpVqZD2lSWJsweTsNvJcNJx
	PsWqOskShpzgehU9rwLNVg+7S/QVadwcgRzsriZ7HuqhGYBW39NmrWkNxDlM+vRJOUVjN2X4e/O
	XLyUMlyBSMTteF/E3eULcNN2M4cuyH38isTt10ObQvdF4eexC3Py4WSU5TSNENYYlTtFvld4UZQ
	DeENb0+ybY8XRA4RieF1gv1CLIzKIoXb5/SrBhXmmmKBxDW6TTInIj+8LXBlfSdTBhCpF3JTZm+
	G08x8EtICuYUF3YZKY1r+WizXYH/kQt0wsYm0xueuNKnqDkZBdQMFvmNNTLk2v1r7VZWTZgbZXm
	UiyWyN37mscJzPl8pK2N5TkgETaB1EWQ+YtCBaElzgelvpjVKG6wtdQD4F2sAWy12c1EWYo2EXh
	18hOhkpkmhf5J9bLSL
X-Received: by 2002:a05:690e:4408:10b0:64d:6cf8:f8c with SMTP id 956f58d0204a3-64ff73d4236mr13831172d50.40.1774966685293;
        Tue, 31 Mar 2026 07:18:05 -0700 (PDT)
Received: from [192.168.2.165] ([2600:1700:220:59e0::914])
        by smtp.googlemail.com with ESMTPSA id 956f58d0204a3-65009326eddsm5590599d50.13.2026.03.31.07.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:18:04 -0700 (PDT)
From: Anirudh Srinivasan <anirudhsriniv@gmail.com>
Date: Tue, 31 Mar 2026 09:18:00 -0500
Subject: [PATCH v2] ARM: dts: aspeed: Enable networking for Asus Kommando
 IPMI Card
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
Message-Id: <20260331-asus-kommando-networking-v2-1-f7d72ae5d40d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOTU7DMBBGrxJ5jZF/iD3qinugLsb2JB2V2GCnA
 VTl7pj0ACzfSPO+dxeNKlMTp+EuKm3cuOQO5mkQ8YJ5JsmpszDKOGUNSGy3Jq9lWTCnIjOtX6V
 eOc9yjMppg+gCRNHfPypN/H2o384PrvR56wvr4ygCNpKxq3g9Dd6FF4pAU4oWwMcUJm9VQkPjC
 KCnqFGD90r8uS7c1lJ/jupNH7L/AzcttXQuWQUBYLTudV6Q3597gTjv+/4LK7ziOQwBAAA=
X-Change-ID: 20260328-asus-kommando-networking-5c0612aa6b8c
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Anirudh Srinivasan <anirudhsriniv@gmail.com>
X-Mailer: b4 0.14.2

Adds the DT nodes needed for ethernet support for Asus Kommando, with
phy mode set to rgmii-id.

When this DT was originally added, the phy mode was set to rgmii (which
was incorrect). It was suggested to remove networking support from the
DT till the Aspeed networking driver was patched so that the correct phy
mode could be used.

The discussion in [1] mentions that u-boot was inserting clk delays that
weren't needed, which resulted in needing to set the phy mode in linux
to rgmii incorrectly. The solution suggested there was to patch u-boot to
no longer insert these clk delays and use rgmii-id as the phy mode for
any future DTs added to linux.

This DT was tested (on the OpenBMC u-boot fork [2]) with a u-boot DT
modified to insert clk delays of 0 (instead of patching u-boot itself).
[3] adds a u-boot DT for this device (without networking) and describes
how to patch it to add networking support. If this patched DT is used,
then networking works with rgmii-id phy mode in both u-boot and linux.

[1] https://lore.kernel.org/linux-aspeed/ef88bb50-9f2c-458d-a7e5-dc5ecb9c777a@lunn.ch/
[2] https://github.com/openbmc/u-boot/tree/v2019.04-aspeed-openbmc
[3] https://lore.kernel.org/openbmc/20260328-asus-kommando-v2-1-2a656f8cd314@gmail.com/

Signed-off-by: Anirudh Srinivasan <anirudhsriniv@gmail.com>
---
This patch is based off aspeed/arm/dt from bmc tree
---
Changes in v2:
- Commit message now mentions that the u-boot tested against is the
  openbmc u-boot fork
- Link to v1: https://lore.kernel.org/r/20260328-asus-kommando-networking-v1-1-66d308b88536@gmail.com
---
 .../dts/aspeed/aspeed-bmc-asus-kommando-ipmi-card.dts  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-kommando-ipmi-card.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-kommando-ipmi-card.dts
index ab7ad320067c1ddc0fea9ac386fd488c8ef28184..e0f7d92efa18ccbad2c336236c3b9d01b7de1bba 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-kommando-ipmi-card.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-kommando-ipmi-card.dts
@@ -107,6 +107,24 @@ &gpio1 {
 	/*18E0 32*/ "","","","","","","","";
 };
 
+&mac2 {
+	status = "okay";
+
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii3_default>;
+};
+
+&mdio2 {
+	status = "okay";
+
+	ethphy2: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
 &vhub {
 	status = "okay";
 };

---
base-commit: 76b4ec8efdc3887cdbf730da2e55881fc1a18770
change-id: 20260328-asus-kommando-networking-5c0612aa6b8c

Best regards,
-- 
Anirudh Srinivasan <anirudhsriniv@gmail.com>


