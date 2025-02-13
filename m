Return-Path: <linux-aspeed+bounces-707-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BD6C021A7
	for <linux-aspeed@archiver.kernel.org>; Thu, 13 Feb 2025 07:15:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ytmfw1vLYz30T6;
	Thu, 13 Feb 2025 18:15:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739430936;
	cv=none; b=b+sdhfxsNNK50I2u6F06UZ75iko7GQKf35XK8FwlSoQ8BvAvtsFvRuL+ySCx4vdgoVdZ4nnK81N4UEfDPeUN50MKxniQQP9W+4BW4AecPvp8pcP9oPgdzn+hFiSsT6uUqPIPwBxLlRac0Aas3wOhYD6WVUvFmNJiOb2OgKw4B0YPSsSvnVQKx+CY2OFM3K/CVjSmX0Utr/A52G8RDuZsI6ZsrGF0tx1pQUKWgRmzLhMo4zTgeyEqsHaJZVhSWP5MuT4VZlTJb7fHzMLRwUzCwGRRYwPNcbU+rBLmhiK9zG8MUY2gHKCjJKLdqb4o/TOlwOcVGwlXF1OSCuUdFGu5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739430936; c=relaxed/relaxed;
	bh=fUcgyWCk+u8Dn7f+PhxtXY5uOs2pwYWI0aCmIl9K7zM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=grVsoBTcLhGt5pqx52qucEObHwkZDTOBhIP8XnaTQrxRRkUc24fQo+/oAx9ACuEe5SWzyzdWwSfMaSFjtRdyMRvGL/FhA7whoOgVq+wUuUVCVlNI29Bs9JErkpdb44INbNFaGsVu4XmFNvcp6MF6Auh4sgpDeJzcrpIFqR0XZ/15d0opjNlLcBoqaRfwu+L8ZvFNDQlU7Le1UQEzDVoOmYDm8by3moe7lIXnQOM2rL7neShCrVO0U7JWHkMns3YW11u5+LXWtf5Ps/kfy6la4S5j6q395mHunVrcIkLFiDfwAw5T7kJ2H390fOxho0sSb+8aCKCQhUIeCv3UwfmcNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=i2IXq4iO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=i2IXq4iO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ytmft57crz2yvq
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Feb 2025 18:15:33 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-21f5660c2fdso9800345ad.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 12 Feb 2025 23:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739430932; x=1740035732; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fUcgyWCk+u8Dn7f+PhxtXY5uOs2pwYWI0aCmIl9K7zM=;
        b=i2IXq4iOc1g5hf2+8/+9UJzRoNB42TUzilpS3kY8h7PFkK26kGOq4dVO9qrOe7g44p
         9icmWteu3WfDGb35zBVS9yzaRPLxzuwDeriw+k64Hd4/hGszc9Qm36LTIrJw3muQMqyk
         UqZpHTVFXK0QCbjQ8PmrF/Zdawwi5Y3HsOeUSli+QqytKeY+//a5wg7blliKynTeVtYA
         mwnHLa4SST3xdqnWUnYRpKtV4jYrnbN0a7g1BRMS6XN5YdvDQO1NOxnQ4hzfRDu3VNPk
         bsK0JOvqLCjtyLNAvHjkJ5vc2PiN5SN/LgIOk8Cz7WNEKvtydQY19kwFBIE6iBgmtkYa
         fR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739430932; x=1740035732;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUcgyWCk+u8Dn7f+PhxtXY5uOs2pwYWI0aCmIl9K7zM=;
        b=vpVWNahHXi5nob2TvkwLnGZ63917JVdk6Z/KGXkCHDAfZDyI+wfczMpGHo1jfxvPCa
         cTAvtwowUPvh3L22ymLHUE+fhkYhEXyh7L1bfqWiDsNIx1YBTzwPJZFflXxcEdl0KIfA
         GRFG4wWYcD2lQKCepEUiUacjmIknvTEOU+cAMtpSSAtxnCGC1DodRs8yneEtU449A8iA
         Pob9RRq+3p5kG/BNt4M6HTToA2BdVJbxYPB1ZRC+2bvrk7Wb8sR/deEiRn5WVeC1jgE5
         Pb+m+YRjY6ecjb00XqRGZGCp/g9lpMSGMl4D7XGzL3Gd4ORzcwp6W3sSfRJSLdNN1Puk
         BrKA==
X-Forwarded-Encrypted: i=1; AJvYcCWTOyUPb3uW5SxKMr8XnosBqk9EvEzHtjcf8uFY3HwNMsQ4RUjHWTGGkml2x52l4t2atnWmcKpL+Kho194=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxNwUrlNg7NEDRytj/+NU5ySvHUIfXJJLNuwB1ltg1lZ2jY8yo7
	6vxq3tax1RD/UdR28PAXZK6OUh36FylilROusPc7di2dYfrcf8o9IaWwDA==
X-Gm-Gg: ASbGncvAP3W8T02+BqClWq+RFriZNn7Gst/ov+JGiQncYojQkr183TwbUNwwoH5lLB/
	JOllPNk5Zyi7Wh06RxWzIs3wR0OniqngomZnXlYOLXWxOT9Unirs0gQ7+aYkvk0bQIWL8B6RjqE
	GSGUFGQI0mgvgmkA36ecjEWsi+fY65Gc/iOwAcG0RXFaznCyLJHkfAKOxKIbNVjxHYfJtZ80U7y
	/uUekwuLjsGytwx/o8yPuWIRw6UG8wnGlQkpD+fKpS8l5+u2YMMwShN1fVgqntVkLVvjCTfML1h
	TffAx7riY4jHNqYRRm7QH/wpBvY3FAM/x06oXtt6Uo1fV7Z+0GJmnHIyHn159ZqoMB7o
X-Google-Smtp-Source: AGHT+IESUUVzPXXPdZpzlDh8rry+98kDAJ3u8IwfE9kokPUoqbExS0rk1/6ABl0gHCy/zI3w64Nohg==
X-Received: by 2002:a17:902:d508:b0:215:e685:fa25 with SMTP id d9443c01a7336-220d1eddf52mr33675295ad.20.1739430931635;
        Wed, 12 Feb 2025 23:15:31 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55866f9sm6024805ad.230.2025.02.12.23.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 23:15:31 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 13 Feb 2025 15:12:58 +0800
Subject: [PATCH] ARM: dts: aspeed: bletchley: remove unused ethernet-phy
 node
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-bletchley-dts-fix-v1-1-c953315eb894@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHmbrWcC/x2MQQqAIBAAvxJ7bsGUJPpKdDDdckEsNKII/550n
 IGZFzIlpgxj80KiizPvsULXNmC9iRshu8ogheyF7BQugU7rAz3ozowr36issVqT6wdtoHZHoqr
 /5zSX8gE4Bp75YwAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739430928; l=1236;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=YNhJ633Uu5JY/VB459x1ZUs/aM+9WIpG3XO2+Tor/5o=;
 b=pZ48Hnh2P1YAIok5bEXIzdHYHBpzJ2kH3ypTFBISHRz7bwesAYGD463j93AuFRLNoAxYZOdbC
 2gpTfAfA22jC4TQQXT86BmoPCGX6rap4V5/pWjOcy/76uXjjozbAwUH
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Remove the unused `ethernet-phy` node and the `phy-handle` property
from the Bletchley device tree. This fixes warnings reported by the
kernel DTB checks.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
This fixes warnings reported by the kernel DTB checks.
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
index 5be0e8fd2633..21fafa4b2422 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
@@ -52,10 +52,6 @@ tpm@0 {
 		};
 	};
 
-	switchphy: ethernet-phy@0 {
-		// Fixed link
-	};
-
 	front_gpio_leds {
 		compatible = "gpio-leds";
 		sys_log_id {
@@ -285,7 +281,6 @@ vbus_sled6: vbus_sled6 {
 &mac2 {
 	status = "okay";
 	phy-mode = "rgmii";
-	phy-handle = <&switchphy>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii3_default>;
 

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250213-bletchley-dts-fix-3cac66ed586a

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


