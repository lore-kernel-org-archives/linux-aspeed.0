Return-Path: <linux-aspeed+bounces-1081-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E55C36001
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Mar 2025 15:24:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJTs60JK6z305n;
	Fri, 21 Mar 2025 02:24:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742484282;
	cv=none; b=EaIovKTdBK7oQLEbLXYMB774tME2dMgm5QeDkCz/vrErLAM9+Iuw0jXzluucbHCaBYnbRfVt50356kL9bS8HEHZXqDqiIsLGCrOAuX1p7P4uJz7TXmiwjYEWEUrC9E2d34T5NDVx3+rgf3xdQRObH2riXMfgWPpHzRhmw+GfoqAA5rMq41YVpJsACG4gyblKYQ0RoxpUdVL5lLydndKb2THTa+e1AyH94UV2oAdk9S0aJNizJsAk1dxQJ9OM0sE7h5fDWIGD9B3CEd84KuMGQwp9noQTSj2kp2SkdeYPsBRURb43rN/TqAIHxiQucm0j/SgyV0bnwPKopT3K0Sh5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742484282; c=relaxed/relaxed;
	bh=VQzvCjPUeOUJnukhemcSwQyPEPsAauix1Um9a/NqgjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hSvufbC3bfke3WMUG6RYEslVcD4dp1z9xGXkTPoKG9rXMtCqD1SjLP3asSuEH2seTlfSATQo+NiOxwZU0m7YB7kmoNRJzHWVMwkGvonyQ/AWuk4cPgWe8XvpI2Rg5AGqZSgIs9useTkjPoo4wq+ge1NpLlh6KI7XUjBKBlPKoeCesUKRB9wcAlrMdEBoJLA9sQqQNIad4+K83ODX8jrHZyPgFSCaaIWNpmfwutj/7JNWOdyCzgrvYET9Ov/OFlQjwp5G6/i2fLvvMxldVIF2yFbsdOwf0BKyM7+PSbYOR1C8BX9Q7RLj03nlti5uK4JvBNKn1pH1ImdHZJmK0LKbUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HwLsrhcR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HwLsrhcR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJTs52xKnz2y8p
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 02:24:41 +1100 (AEDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2260c915749so12856525ad.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Mar 2025 08:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742484279; x=1743089079; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQzvCjPUeOUJnukhemcSwQyPEPsAauix1Um9a/NqgjQ=;
        b=HwLsrhcRocdb+xszTVrhsSkngN9KpFbpp1FT6b4GDbRqrAJoGKyCOA3/Vi6PqfGbYK
         5CMJ3l5A2gPPxmYAUMXZA2ltkMEt2WmSqAGMTZ5IQzdomzmd7CGmj1/mklMq2I/6JZTZ
         7DKlpjVxG90+ikrTLj5yNGZ5kansIAT02WXtt5BDEbY87tUG6XugRfvhjvYKHoKiafJT
         ZnE2bZ/FKGTNa8sB5ngaPidNRwEX+2UEz9lkCMGAnnhzLMWUyaxW7G0Obr+fkWzOVwfx
         O8tnpPOI43pu/lgI8G0jVEsKBSyNRiJW8wG6ZqdDSrGZlmGvNvSAeL0CqvhUj+hU08PF
         tzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484279; x=1743089079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQzvCjPUeOUJnukhemcSwQyPEPsAauix1Um9a/NqgjQ=;
        b=l0XpumIY7dTFw7idPYsNEk6vY+IL+rG4QqHcp9+cAKVdvNbsUoEN+tDbsNjKdX0fFi
         Lzf6RlEs0bGWdjuhung9Y/4sfQnyRaiMU6kC2t1wwxD56dCLugf90BzIEBsG/iQvuFlc
         FCYyrwzl4CysfxdVQynyI+PW28w314TF8YTMH1zCv4+yV7f/NGRRbKLOXu6qHun4MCHt
         IIGEOX1rL8Nep+FnqJGgB0F8r4yibTPm/lGLi73QB389qMvqCR0FWgWwZagYkJvMkBpL
         Pwlm5DSDq87B317TQsEwqYJMac9JKirhxlP6qLseyqPqif7tu96ZIB/JgByfdPN07CO0
         OlsA==
X-Forwarded-Encrypted: i=1; AJvYcCXjyQ9tt4WWnljBBKkVQrosRM1i12KtA2VGmzm/GX9qXpz2XHiJQBVtrgO6RhVpA6QxIcQP3pT8OtG/Gjg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx5Qhos5uZfECfl37gYgrUgi78EbTKws7DINqSKi/rch2qt8e4O
	LilPPk8bfjW96k/VcSa5JNq48GTA9VqfA/NHDxSo7hBJ+BYf3wAz
X-Gm-Gg: ASbGncupEtXjWVjxOwtQMANsfz79OiddaH6dgU+H2wbZkMOwQnpU3gAczOD0XeqRW3k
	YKMWsGZICbn2UVeNFRe9OOZQ2jj5s7jHZ9NelXmpz1DAFTS1oqVNsW747m2d5AhAK2cQBOE1QoE
	wkNELzC58xIl9KP+YEq8sydqSYm5Mk39/1LPinsHqUdK9b78Bf+ONXAeyjxihRCf8JLB4XToiE0
	GBEiWJtk8rXC7ftQrB0F2Z07UiUaTspYYTcKfB5va2+gIfHxZkVwaW/t+G/EWHwfHe9Yk5bAx6c
	Lehu752xXrwYFqNKXbtC20nGLtZA4tr0l5comTZPymjEvQpvjQuiG7gIjSCpGM1QRk3RyZFT8dy
	HDvSPx09miMZ4L3NRKvHCRg==
X-Google-Smtp-Source: AGHT+IEWWSWYQnuesBw9k5f26MYFCg+MyUeosBtDDwCduhJQbl6yXVq5xhb2uSlQ3VFKw1iUppK38Q==
X-Received: by 2002:a17:903:2985:b0:224:1943:c5c with SMTP id d9443c01a7336-2265edbbb2bmr58534865ad.15.1742484279224;
        Thu, 20 Mar 2025 08:24:39 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4a8fsm136905515ad.234.2025.03.20.08.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:24:38 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 23:21:54 +0800
Subject: [PATCH v5 04/10] ARM: dts: aspeed: catalina: Add fan controller
 support
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
Message-Id: <20250320-potin-catalina-dts-update-20250102-v5-4-e161be6583a7@gmail.com>
References: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
In-Reply-To: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742484265; l=1019;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=tF3QpIdL5ecs+vvtM26gTlh5RwwxqroHT4QqK6Ir0Oo=;
 b=kiFXK8/gH/YJo/qFRHAElfjdPtoGC2XzQKFNmKfgU23jH0UyyUTD0SljFBP6KSEHH+MbMRgyc
 GBEZb9rT6+rBgUvAvOaS8LTT/r3wVhpMpx+DxUkuO6im9ysNBDbQLfC
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add device tree nodes for the MAX31790 fan controllers on the Power
Distribution Board (PDB). These nodes enable fan speed control and
monitoring, improving thermal management and system reliability.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index f5f47245796a..fd22add90449 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -466,6 +466,15 @@ i2c1mux0ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x2>;
+
+			pwm@21{
+				compatible = "maxim,max31790";
+				reg = <0x21>;
+			};
+			pwm@27{
+				compatible = "maxim,max31790";
+				reg = <0x27>;
+			};
 		};
 		i2c1mux0ch3: i2c@3 {
 			#address-cells = <1>;

-- 
2.31.1


