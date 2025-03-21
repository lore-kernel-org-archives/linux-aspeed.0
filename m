Return-Path: <linux-aspeed+bounces-1108-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82819C35FFF
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Mar 2025 07:28:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJvFS1Zhwz30Nl;
	Fri, 21 Mar 2025 18:28:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742542124;
	cv=none; b=YPii1I1fdKfZ4Yrq9uKYBurCk7u2wA5tIkoCQbbZvYXoPjrx9gxJQc07S1hR0WItu5Sa09jTsXPWkb4OLwNPICyCBixco6C6np/NrzNvNp4k5dSyt5IAK74J0vMI+2MvOEYeCXTXs5p9jqw0hE7YYYVQV98c8VdMeapzuZ5XPpO12mAD7tFJXRP9rD6TT8PjrX8dNEFIq7sI9gtR3lFhlEyPmrpUcJZvqMcrPXjZ3B1Px60L5yi9NF5/ZJ6sTBrIj2Xn6rL7AcGIEal+0sMcrsrPGAcn/vkeeJBmlDcMAiPOHlytA25jCs0sJTomluin6Jt91TNdSv2s+vxMgzQSwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742542124; c=relaxed/relaxed;
	bh=ieptwck2xbumRisfrT82whFeQnF/qSu7PPBUcK7FiUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i/5t92GcP8IkQjB8bIe93mWtMU0rqwmFQE1KCAg9aMy1XdPfEiAoPHeFPyhp5HVVv8DfCyCbSduPqh/8tQqsrIRZIU8WJnh51nYYV/3O1Ty7/0l/J3uvG2WmLXBO4bWm+dvBKtB7G8WD6WPHlDjWjHwN4P2FG6Whyh8uhOjrwlvnsdYqahoVEY8Y81C9tLHCDAn0QabxsIz88ULz+KjhFHZp6j06TMzzwpun0rb/x5zLJb1z22szy7AggAjGs1/4V8oTxz6s+QXuJWmLtgxVE0fE5vmgjmaeR6IFQn1wNZz9dIPwACwSs8TRBykpA4hpbasElz5NcYJRBVpP/54ILw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=O7XxkVO0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=O7XxkVO0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJvFR3sZFz2yrS
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 18:28:43 +1100 (AEDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-223a7065ff8so50534795ad.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 00:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742542122; x=1743146922; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ieptwck2xbumRisfrT82whFeQnF/qSu7PPBUcK7FiUw=;
        b=O7XxkVO0tBcqtLgNOZ9UGq+ZcG0tHm9VtIub4+Y7Y/9sUpmQ6ziz/9sxRD/MHb2OOY
         p2Mq9Kake6+jL0aC7xRlhocWMPSqIkZ4CA+nGeu8quztYjtVdqV05WlWoU5dje4B0HEX
         snQmniTgHqgSVNAmEQIHZno57Q/EUk51KF0CbGwV5USiYkT9pwgYPB1xNTWT62nf9lj/
         WHTiNKZGiJ3vTxMRquqcXOY2wmBUS2Yl9ExcW5DFb2WYIRvu4mT89vsYNjDrSaU9JUTr
         ZhF25CpiWDxHDVN4j9EpbcAV3FHo9sWlIgymsTz+y3UTPO/ObBajI941WtHvRALIQ/L5
         mgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542122; x=1743146922;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieptwck2xbumRisfrT82whFeQnF/qSu7PPBUcK7FiUw=;
        b=u+qjjcX+lJt3Dm5VT3WLITlOVezNSNwnSoSJ9M2/DRLhCNj8sxwEaHrKzlGpts5j4a
         nsNp5ROGM9xFVU+owU5EJE4AVOLEgvuXUdDtCOP6pPcj8BW2FJ9z/lOplLRJOLaXfvDS
         nOVuKG9ATgWVcQLYdkeSY6MH4O9CCDEFHmomXvzCEkPhNDtfwvRFdrNPtzKTsMZk/uo/
         L71VbpZpNRDyCF/4ZFjEEkkwY485YRiX31g0iIdfUgJkjEDZOQ8qGRJNVzBNllmAvAnz
         JvRXV6KfPOEnGPa0GlZYXk0JYpkKyZscipbyviFi/0r9e60Rxg9CLVdtTA5NsbXOsSoz
         jG0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzegmBs/6k0edY0qsXGM7KMfucPjQQz5ePVUIbOBN0L4JaT/JJOyG5++bOKE/BFJ/bXgy9rVh+fHqIChQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz4ZUJwNtOj7RRQnPoqiYK9PNzZKTjo2oVd3YMfFq/kKUjYdLC6
	/Rsm8YTmhsgAN9imKQ+o9Z9eu80yClcIfrJ5Qm8JIjWMaW7OY9qD
X-Gm-Gg: ASbGncuckVP9iVwwoO4DWlzR5PlW6txpkfhXdJaJLHc1TkI+iD03NYerx4NxvYlRmmO
	Kt2w3EhIEdJjDntwZB1Ax88r3Ad6xaqEemL/B2v1nCh7Zyc+ugODnz280ts2wH3WVYTOFM4ihxd
	RoJRdYpc3uMairgWOwZcuyeTsbWBgBlE0lNPaiXAh1dfKZWIYPXAXptG82yDHjekyDINM1HPhnn
	1/OmvxlQHvSVPMsnA7tQSqywLbznvbikce/LH44DyhKI+FJ9beHOz1lL5Sz/5eEA4AREgoaByu1
	3qpOMgJp5nkD9oFDG4ia6jKx12ynEQk7XC8mEkOjthrKLDPvwrAj6Yc9OPqs4IUttabwbiM2gmU
	ljadbYDXUxhlpxwPRe1JUGA==
X-Google-Smtp-Source: AGHT+IEjNtFI6VP/om3wHuMPu5o9rtQHBWQ3PoYv9Ejx4ZNfKMN6ezeWRVywDwtXRCBYtYNbqvqmXw==
X-Received: by 2002:a17:903:32c8:b0:224:1609:a74a with SMTP id d9443c01a7336-22780e14a50mr37653095ad.34.1742542121920;
        Fri, 21 Mar 2025 00:28:41 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f396fasm9862265ad.27.2025.03.21.00.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:28:41 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 21 Mar 2025 15:26:07 +0800
Subject: [PATCH v6 06/10] ARM: dts: aspeed: catalina: Add second source HSC
 node support
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
Message-Id: <20250321-potin-catalina-dts-update-20250102-v6-6-4bd85efeb9b4@gmail.com>
References: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
In-Reply-To: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742542103; l=979;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=5pcZNEUlvboNDNVPjfP/G7Ub2nFpRDTz1Jz2es019M8=;
 b=M6wY+kwMmAqRc2ixbv87/CrMLBRU7CN3BuqLHOdf6m5VlQvPK746/lKcFe0Hctj5iynCwOVZX
 s2cVFyFDJMzDo4NEQ88OMn+gfMFLSNydnqhPvBj9j6NMeddnDJLRHMN
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add device tree nodes for the XDP710 Hot-Swap Controller (HSC) to support
the Power Distribution Board (PDB) with a second-source configuration.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index f0c8aca152e7..306931c08cb0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -562,6 +562,14 @@ i2c1mux0ch4: i2c@4 {
 			#size-cells = <0>;
 			reg = <0x4>;
 
+			power-monitor@13 {
+				compatible = "infineon,xdp710";
+				reg = <0x13>;
+			};
+			power-monitor@1c {
+				compatible = "infineon,xdp710";
+				reg = <0x1c>;
+			};
 			power-monitor@42 {
 				compatible = "lltc,ltc4287";
 				reg = <0x42>;

-- 
2.31.1


