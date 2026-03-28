Return-Path: <linux-aspeed+bounces-3810-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139FC1061B22
	for <linux-aspeed@archiver.kernel.org>; Mon, 30 Mar 2026 22:42:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fl5ps4kBpz2yF1;
	Tue, 31 Mar 2026 09:42:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b12f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774741218;
	cv=none; b=DsaQiFSfMihtzyHNC6TEfmV0u26fnOmFdTK+oMyStaRazEyii7/gcBU5drGjqJlK24gxQTZd81tnAZGc07vAXtKFUVrIfYQ3J/giZnn6+csLSi/d5QPqLF26w9mbJjJxLzv+/uBHDE+B94Kgd9ysDbOO033Q+KKuS1zJdBSeYtaoVnByCe/evCcLWe+2rfzLyX49+ddlqkbt7oy2Oiadofrwcrffa+/dusbDcSDSxqqM224Pdj6NsCNhhyIAxHuCtzjTXZYiX9kLi4+ucaBBeGPQAGQDLy2BSGuSh+MLu/48CFa/i6VAcmf+Ew/x00sp0s9O1Pwi7v9gQiuVvTLYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774741218; c=relaxed/relaxed;
	bh=D6KQA/Fx9D9/4JQMN8XwpW8Ndz5zn5yIIrnM3uQJKv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Pq2XXkA1gqLbIL1uo4j3UeN/s3D/ObRHchsdfRLFNc4/PyHNSGWf1fVPGdzz7jB1XjZLxqRCJsoALkwVnkE9+6NstUnyrESpb3LDFSpXwqyfhWFOo5bNvQlV3VGg0r8o9gZ3C0bgLdr3zaVcORMCP2dwR8R5IUhQ8rAmCeypZ5v2nVE7M+iZf+mcpKcgwGsjWLwZspBF5iQg6qsVSBpfMyknV9gzhlLWHag8edTynm7xSmrSZF9GoevNu4bZWc74rjKQ9lRKM6re+uAN2MkfJNOnlWkh6sAxcSuYKS8ZhOIHR1AM6wI7O4RFCnDFy+1Nts2KEQoJHfZ5Wm0yEqhQFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MmzStwTx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12f; helo=mail-yx1-xb12f.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MmzStwTx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12f; helo=mail-yx1-xb12f.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com [IPv6:2607:f8b0:4864:20::b12f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjvBn19N7z2xTh
	for <linux-aspeed@lists.ozlabs.org>; Sun, 29 Mar 2026 10:40:16 +1100 (AEDT)
Received: by mail-yx1-xb12f.google.com with SMTP id 956f58d0204a3-64d5a7926cfso3881546d50.2
        for <linux-aspeed@lists.ozlabs.org>; Sat, 28 Mar 2026 16:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774741213; x=1775346013; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D6KQA/Fx9D9/4JQMN8XwpW8Ndz5zn5yIIrnM3uQJKv4=;
        b=MmzStwTxJxGjKGijunJr8tz6p3DCIUTZq1LqlPEZywyo2TYGjtAacErcwgS7y+5PEb
         JOEa/LjPdpMRGTDjD6IovJdkxnVC4fQo1djOhnWr5mp5J9wZcpNFICJb+ht8LbvTijwv
         TD2lbprHnoU4LAGfbmK5w4NDE0c115XoUub6DbB+mdU60MpB0hM+gI/e9ClJKaGQA45o
         xwOcZK4naBacnRB2rQXg9xdXIQDI6wIMFKlObq1CT7wSLzN8jYj//H1Et1oxt4BeSnVK
         zOzSTKQPp4bT+1QQ0N3s/ZKgd7ho0L6EjJlr+Fi6j6CYF1XIaX4Lhb9TCJPn/fDArpBa
         qvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774741213; x=1775346013;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6KQA/Fx9D9/4JQMN8XwpW8Ndz5zn5yIIrnM3uQJKv4=;
        b=PUiI+cN0ksd6rdgNqDoj6bsCMRnIphKP9+BJnNi7Cf5u1FYbO2liXmfOVH3tNIg4Xg
         sVIknjMd6JKShTv2UIWWiYDdSHV4mn/o7j5kGepN0m6n3U+30a80RyWI3kImldFb+4CK
         aY5E1qkq0kiqjbFqVX93uXbHXQx0KgpIApM1piY5Vf9MoSmoVCPopxOuTyL4pEz03HsV
         49SOdKsi4VC4awBh5j1NDjNMWiOUJtwiCJMEzSrQsIud+fwwCEXiSZolRGfVBnLIvcFR
         wBLD33qDKwhRKlgD/MY8rKQYR/iUhNeUIETyqoVr9W8KrP5kGvW515wp7Cg1J0LD92Ql
         Q4xw==
X-Forwarded-Encrypted: i=1; AJvYcCWbMs6p7A4MGkJ/+QzjEPUhM/gaHlvnS3veaNEJkXxcYzsGj1SFj6sDOuRY2NlTZR4tH9UA7B4rXxpBVaQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwOjSpXkQMLEWzpcIGuDGml9Cj6hvHumMmbeh/EcoMAeBX9nSm9
	7hs5FyL3l1y9PEYV79DgoPkIushL3W1ZvmaNW1jRHi8c988arhqcDMgu
X-Gm-Gg: ATEYQzziBIqm06NIy8y1+pURPLI96DoQIpMz0VMdpHvQ+LrpZ5+9RnmO+hiFekCI3Wg
	98A+ge8QQpY+o2mg7Q9opX4aqazBHtRuLqKrTXOFtxVPGT/BetaDpzZLeslJOyhBGJz20zDe1oi
	UXGSUqFPq6ZtKk6hJxtODQjWmQW50f0l2Bmu56bRB8HsZnmGRZkOWfvRawRYYR62ZjUZqmZ8BvT
	b69yK9CckuNd4K0uAANkpf+Ey2/mZA1F7Zi6+UoAjZjOx11GKiBYNxDXg5DvXJAeN63Ll/uOvEK
	loRuy4yzwH6yxQ0jHxnZL4ublsKKZHC+LuE9nuKmBiiUCPuF+7Rd77GR9LmsARTY8v2oCVt+1En
	P61yN8gwqYUiYthgeSnl0Byk8gM2JdImnMYr7UsNFPyE1v+qEz2/FUpkrdBxAUx+tS/1fCMv8mQ
	ZtMSqNLx8RSDRpsoXa
X-Received: by 2002:a05:690c:387:b0:798:3be8:b68a with SMTP id 00721157ae682-79bde0b7b15mr78629767b3.56.1774741213414;
        Sat, 28 Mar 2026 16:40:13 -0700 (PDT)
Received: from [192.168.2.165] ([2600:1700:220:59e0::914])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-79cba66cf09sm15559127b3.43.2026.03.28.16.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 16:40:12 -0700 (PDT)
From: Anirudh Srinivasan <anirudhsriniv@gmail.com>
Date: Sat, 28 Mar 2026 18:39:59 -0500
Subject: [PATCH] ARM: dts: aspeed: Enable networking for Asus Kommando IPMI
 Card
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
Message-Id: <20260328-asus-kommando-networking-v1-1-66d308b88536@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNwQrDIBAFfyXsuYKaRqW/UnLQdU0lRFtN2kLIv
 1ea4wy8eTtUKpEq3LodCr1jjTk1EJcO8GHTRCz6xiC5VLyXhtm6VTbnZbHJZ5Zo/eQyxzSxAbk
 S0lrlDEKbPwuF+P2n7+PJhV5be1hPCc5WYthScb11WrkroaHgsTdGo3dB99xbScNgjAgorDBac
 xiP4wfEBxgrtgAAAA==
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

This DT was tested with a u-boot DT modified to insert clk delays of 0
(instead of patching u-boot itself). [2] adds a u-boot DT for this
device (without networking) and describes how to patch it to add
networking support. If this patched DT is used, then networking works
with rgmii-id phy mode in both u-boot and linux.

[1] https://lore.kernel.org/linux-aspeed/ef88bb50-9f2c-458d-a7e5-dc5ecb9c777a@lunn.ch/
[2] https://lore.kernel.org/openbmc/20260328-asus-kommando-v2-1-2a656f8cd314@gmail.com/

Signed-off-by: Anirudh Srinivasan <anirudhsriniv@gmail.com>
---
This patch is based off aspeed/arm/dt from bmc tree
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


