Return-Path: <linux-aspeed+bounces-158-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69843D75BA2
	for <linux-aspeed@archiver.kernel.org>; Thu, 21 Nov 2024 02:53:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xv2qY0gcmz2ym2;
	Thu, 21 Nov 2024 13:53:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1129"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732157625;
	cv=none; b=IeainlCsqmS8o17J+LEaZXPDeXOyMT0w8bKe7t5gVrQfEbJdqW77/QrXBqbFxL/9uYmnO1owPZQhIm/T64/myBexlG0sqYxeF222TZEVfKlIAgD0i1G15QeGUdKmtitDXG2UrKDzKQ6Tp4NDghZz+kXeR8MZe6L7yZnxT5xwpf+8T311maLRpanQtk6C5qvM2rxYpjeyW7M95BRuUVoGH428n6fYbhEWLKU3cTxhaIpLpbDpmVDxp2Vkub9WZT8RtiZ3E2KFgoCKp8PKXitfI2+4tcLLfa0RBH9A1umrmTzbMbd7crQyWWdpJA/v8vdAHF8cLRK5AJaaKUQ9Y5KmkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732157625; c=relaxed/relaxed;
	bh=Moeko09cNn/tBMWxRyaAP4nMoxzoQVrPZMKwS5ag9u4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lnHWZ9JQkaR4B1swRYM49wGgRhI/4VdfitR1lwMrKCOG5YLxxvr9ByiiHg5NVu5mDv7rRaJb84C4YmN0UvkxHH9BX3Zj3AHOdenJFTLywLuBpkl2QoCXOeTAxGxB0jVsN/1R0mq79KNRxB27mvKnVeAGSxCTqQTfQv23P0lYWN1s0oJ97t1GXH9wran1CIQnzbPdcf7Ra4WU9IWjp6m48JiVlOBPsUIEf1k6IYwYGAtbHKQ9l7SrRfvEOZOolFrmHBw8Mt5f9aDfKchkr+06vkTmixjey4unSnX1Oo6rr9vlC0Qz26lpY562VYV9XGE3xRsspo7vE/Q8TALXEZnjPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iV9Pjl7Z; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iV9Pjl7Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xv2qX06stz2yD6
	for <linux-aspeed@lists.ozlabs.org>; Thu, 21 Nov 2024 13:53:43 +1100 (AEDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-6ee59ae27dfso3291367b3.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 20 Nov 2024 18:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732157621; x=1732762421; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Moeko09cNn/tBMWxRyaAP4nMoxzoQVrPZMKwS5ag9u4=;
        b=iV9Pjl7Z/AEHKnzFjwSZfI57BOIeH3l1BQPph45Y4LG/WuqVD4vqk7hQZ1GXkgEsFr
         O8n/Wtn4xdrjSqd4JOXIjukUFu1v71FvFZYddbuSPXzyuLmdYSOWxBQaXcXtjCXx+tmz
         vEWcXQSYRQxHE1F3l9QM4ziggxmJANkKTRkk60N5kFnIoC3FZlU8o72MtXAqGVVr0CrB
         ZAQH3aP/fSw+ZvT4MlhtP1eSSs/ES5N23uzhNURKilaClXHXzRaKz0kPD77A/TTM6iP1
         HTZON5y0fq8IC8O4gKMmpZvrEOS4ITMrphlWMBtdegxhQ2/BVtXAcgPsHMmR4SJRxvre
         2CNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732157621; x=1732762421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Moeko09cNn/tBMWxRyaAP4nMoxzoQVrPZMKwS5ag9u4=;
        b=CR5dWPPp4vQOrw5XSOkUuLw2lZLl7g1hDq9oem3TcZiYseTZ3JO90Tf43lLF08Bw7b
         2VwlxRDgyybfJ5Onbva7anQf3ZSv2GBqyrhp3BR1HRvV4UDW/VA8JDtqJz0sd7PDvtgB
         GVuQhIXruFMKraUiag0A7BF6CH5B+RARed0pnsTLR4STRSMQ3jWA890U9erg0+FMs7ip
         pWytz1T2s29iPd+hmLdIaN9nUXMV/OU3sqZNznW9vp3SmCsDT6ZGUyxmfEa0GD+p9wM5
         LmAozMVTBY8+3WoPGkI8yHnWArRRj/YgvsWxYnQDlLM8dmUlcmNTRnq6te1eWecgotw0
         EGZw==
X-Forwarded-Encrypted: i=1; AJvYcCWuz9uvjJCUezIZbny6kG0F0ho7+YbhAfznpJIvEYddHSrgU5+VTDiSfgV1PsV9w4Wu134Dm0VM9rNIkus=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwfcCC9rikb+H7DFSglmuLQXjnp9ESUzCyfeZLI5TT6XQSll8Eq
	sSr9XJboHs9atsG39cFwvCWPL2t71RQffOY3XF7M02gg2wF23RrcE5hpxQ==
X-Google-Smtp-Source: AGHT+IHfi9U3ChAkSgcxwjTETaNCq22J6zc0QHGyI9uwWq7ryknGbpWpSp8Z2Ihu5uyhiDydYDfSfg==
X-Received: by 2002:a05:690c:4b11:b0:6ee:b43b:62fd with SMTP id 00721157ae682-6eebd2d1a9amr60919277b3.41.1732157620851;
        Wed, 20 Nov 2024 18:53:40 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e309-7a4e-e779-1177-8427-3602.emome-ip6.hinet.net. [2001:b400:e309:7a4e:e779:1177:8427:3602])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb64f5514sm285513a12.34.2024.11.20.18.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 18:53:40 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] ARM: dts: aspeed: Harma: add e1s power monitor
Date: Thu, 21 Nov 2024 10:53:21 +0800
Message-Id: <20241121025323.1403409-5-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
References: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
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
Content-Transfer-Encoding: 8bit

Add E1S power monitor device.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index ce1731bdc1af..9d7e7208562b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -354,11 +354,22 @@ imux22: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			power-monitor@45 {
+				compatible = "ti,ina230";
+				reg = <0x45>;
+			};
+
 		};
 		imux23: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+
+			power-monitor@45 {
+				compatible = "ti,ina230";
+				reg = <0x45>;
+			};
 		};
 	};
 };
-- 
2.25.1


