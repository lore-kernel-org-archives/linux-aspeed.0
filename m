Return-Path: <linux-aspeed+bounces-2059-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E50DCA0EED
	for <linux-aspeed@archiver.kernel.org>; Thu, 28 Aug 2025 07:50:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cCD8P0BXqz3c7q;
	Thu, 28 Aug 2025 17:50:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756367412;
	cv=none; b=QdulpvmJ6RaRiLc1i+OPua/3dSBv+FDizq4duF3y7GdKZRIuGJBm33ArNs4plfYVtwXh0n0Mtihcwrg2lmNoc4mRu9/k/5kP1mvqfOErZPW13hdPoIFSC7BUzJEDzeDLa5YGfSODj4617vMJHMdb9Aoif0EiRfMBZtfPawK3E6DX5VPf0cvg2ZWJINDwxcosBLWsW+wC8oCrE/2BtnzV2XY3S7Dbryi+6ijTNxhty6VuN5QCWfLj//ykoBS4pfYyhI7XwweEg38w2hD3AKkShUh+Wud4CBzeN3887p7cAMKJcv+fm6hpAAo+s5KyXzJ5sHY1pZX3zAoBs8eGqRb/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756367412; c=relaxed/relaxed;
	bh=Vni583dy1qPpKoeI/BvuSUANKkix8/DHWprmu6YA31k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMT/XCI/R0SpWgcdJz1r14mFDy9PFaEJIOaVxAdxKDcLeccnxLE07CPxZ2mUYI3JHfLYFvtQuoTgnErxLa6snWxC46GN0HVxzBx2JNPgtSUUKxCt+uDNVAB8gLoWBxPHcjzc9whjO49pDefrG10u0RoK9Xvfd2/oeIq11E+mP/cUZZYIPNw2N62ee1VkeZVvCfnyofJfkjn7xCs7mofZLDU3t9EmLhUlcFvrCXDunOwhiKZy3iUYy16Cv/fwFK+2XrhF7yYf3YboCUSpz8bRnXIjahbSVdipra3YWL+N39/ZkF9C/FDLCr2nJRRLVQak4rav+vN50FDAkMNOHl4kjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ONTC0ZYE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ONTC0ZYE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cCD8N37G0z3bpS
	for <linux-aspeed@lists.ozlabs.org>; Thu, 28 Aug 2025 17:50:12 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-7718408baf7so671718b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 28 Aug 2025 00:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756367410; x=1756972210; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vni583dy1qPpKoeI/BvuSUANKkix8/DHWprmu6YA31k=;
        b=ONTC0ZYEXWnv8MIp46vHBu71FV8y23VTtH/VZTW2aepOpRA9vcWIU1PRpM78oLBVVX
         j3+3bQ+F7+3x3FbOOS6Gvwv045WuHlCLadL5ZsdpZEusmYJ/hGVEkN+HxOb9rgdtxzNk
         PyhxPskOMwJ7D/rbx0O6I91BvvLAUfxwm2SfYgxniU0PvJ800KbXZkCghtevTMXiBnk0
         s+P8LME1q1fs52O7/aiTTf5ADec3n9P5YyolQEsg8V4TCKcirgCgJBOvg6R1Y3z/KC5V
         My7vt//Nxx3qnrS3j8v6V7BKmiDGP8QIwXotzwVOro1ROXGenIToKybWRjQ2gJCHe/bT
         u/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756367410; x=1756972210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vni583dy1qPpKoeI/BvuSUANKkix8/DHWprmu6YA31k=;
        b=qvDJTV6kcu2QmnI2wzqekyfzhUJwvItgfxlK8FPk1asglT6kxpO5FmK4D/iVogCp4m
         Cp62NOFK6UDXEIANF+sqPO5mKfaoEFT74T25pYog0lCETqvf/Evd94XNJY13NznXCniZ
         qxq9UnUn+o0cBpU6r/BvvWQBVcu5fxWb1qi2uf2w8ZyK1JxMT8IeGmJe+oeWOvjShYXF
         DVIuh7RH+AKZTOgPIP6dRmJqKsvQd+noDMQqHTi/wWlEYo9/5GAQppRgzJzuTDNamyFy
         w0ziGfq/c1XxFAbzLKkFRtc7clyqeyZFlpK1Vd5ecMyZzu19GgJAD6vTjwjPks0kLy5L
         TaQA==
X-Forwarded-Encrypted: i=1; AJvYcCUjQ9OvnSfS29LCRnQZu6F+/ZWCe/14z7l+CY3cd9sjSBYtwxJiqvGZNn3pgIYbrl/n3B5vcZeNxQxj7Zg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwgvPb2KYRUOEMaa9fXXB4I7gDBOQ3uZ8L/il7eP9gn+QXqliuo
	Zs1WJGzE51ukz177HRbtsFH+/IluI7iQnlmlNA79yn+oKdy1TWG+bbAy
X-Gm-Gg: ASbGncuze7cqDnBlboyRcrtBUlQkBuzZM/roiePd7Ik773QUQh6nWScE+Dy0U2rXepe
	XoDpWoonA4JeIV+wFmYgXeaiw1c1hYiwbUeF6gTCWUqLGqVhStLZDG36lLhvIzzhqx1EIVISMTx
	DYzyBczhhAJbXr85b6lDp1E34F1o22qBTstv9bX6DPsfbWJ5DWFikr2R+kGwtTh7yNVgfC4joCY
	xWP873d3hu7bdDlrWpUjHm6K0RpfVnTX0JRXpdODPL54w6a8X/HVEAS/Bh4a9WPJwp4YV8a1lWF
	lKgSUGcfgkZJUTsQH8NbYUUhc5Zh6CKqby3ysX6S05WEsLc7/fS9SB1tbVyyKVPpdsPMmOg5VZT
	t1gdUUdPPvRpBTTEOnDROjNRtMe8sQIMPT6NZtEr93RHxmqSq3Lyuoc2o/O+x8ctbwOMi4+R6LI
	sfuRuJmfDasWztZY7aybkFM4xRwhSN
X-Google-Smtp-Source: AGHT+IF4HC4PbFCqww/SIqTzmzziaZEWvmMs4ySjP/B1BpUGSc/ehDGuZDBlPqwuqZKik/CkkD4VWg==
X-Received: by 2002:a05:6a20:a125:b0:243:aca2:e500 with SMTP id adf61e73a8af0-243aca2ec8fmr2970429637.29.1756367410222;
        Thu, 28 Aug 2025 00:50:10 -0700 (PDT)
Received: from peter-bmc.. (2001-b400-e35e-4238-7ad6-5c9d-99c8-92d0.emome-ip6.hinet.net. [2001:b400:e35e:4238:7ad6:5c9d:99c8:92d0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb9d226sm13272038a12.41.2025.08.28.00.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:50:09 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] ARM: dts: aspeed: harma: add mp5990
Date: Thu, 28 Aug 2025 15:49:53 +0800
Message-ID: <20250828074955.542711-4-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828074955.542711-1-peteryin.openbmc@gmail.com>
References: <20250828074955.542711-1-peteryin.openbmc@gmail.com>
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

Add support for the HSC MP5990 device on the Harma platform.

This change updates the device tree to include the MP5990 HSC
(Hot Swap Controller), allowing proper configuration and integration
with the platform.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 81278a7702de..23eaf47a38e8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -520,6 +520,10 @@ imux28: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			power-sensor@20 {
+				compatible = "mps,mp5990";
+				reg = <0x20>;
+			};
 			power-monitor@61 {
 				compatible = "isil,isl69260";
 				reg = <0x61>;
-- 
2.43.0


