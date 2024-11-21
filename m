Return-Path: <linux-aspeed+bounces-164-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2491CD75BB7
	for <linux-aspeed@archiver.kernel.org>; Thu, 21 Nov 2024 04:36:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xv5673XzLz2ynL;
	Thu, 21 Nov 2024 15:36:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b30"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732163791;
	cv=none; b=lXkVufC8cubGRNDZIxYbv6HewPOqnZpheGF/412uV6aPvTZMaYxSj+ytRLqaLfKFpJ0pzECLeZZtNofukkbvk5bJCUdAQaR7RKa6AnoAt0/RqGOYx84pEzotbI+NwhYwFAW1hQ/WABYCsd/7WmSLp8elnBX/ctU7iHgQlS0/aao2Kgtb6j6nIrYnbSmnW8dM7aBM0MxKFrC/VgOYYOWZ5ExrkXJBslSty5baKixl/E3T5/S5WYfbs2atmrRwrXqcxdnIABVQDAo5B3fCfVjHIWkl45ERvdngVDb3k0USipunUFhWKNNtJgSh1lPrzQX1erxTkb1EcYyOiSIxUNpCaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732163791; c=relaxed/relaxed;
	bh=nuyF7+8Fz7Mpttrs+fI8NL75TsOEWtX+J92XFGbgaKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hoLJ55o9Aa18ICUFtuOhzrG82gozdMGgbfhHiRB4tPanHkZt7kD64gQJyNrKSGGUSl9jXDOY65DFUjjjBzsQX8dJYIHdSYPnN/+GaAlsW67vNJP5WnA/KhBVqzDvcBnA/wjMSVO48jAiIHlINy8fHXWAJ6rgb8TojJ5ZyJa9hJyjlELdsQeIZ6avNNXLWV8iQOKvJyitmg5tsjM8VF7KjEMB3PRYDVA1MXCSLWgxBPCxRBE/JwktSg0qRB9ZPTaJdpfT5D2eya7WLbFFgNxeiyWN0mf4pypDm3a2mtiLWYM1EosDkOW8zYSwyEMbINLH4B8rz9j/YK+sL4ZfCDLl2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FMbvLPIj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b30; helo=mail-yb1-xb30.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FMbvLPIj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b30; helo=mail-yb1-xb30.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xv5661yx6z2xgQ
	for <linux-aspeed@lists.ozlabs.org>; Thu, 21 Nov 2024 15:36:29 +1100 (AEDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-e387e50d98eso380622276.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 20 Nov 2024 20:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732163786; x=1732768586; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nuyF7+8Fz7Mpttrs+fI8NL75TsOEWtX+J92XFGbgaKU=;
        b=FMbvLPIjV/JBhELyPiCJFOeFqs0cfVhr9MNvMXHKRMrmUmmOWAmQ30+LV9C+3wXvnX
         I8plX8nsEzVsFpGTwbMIJ9jx/XVEZZF1tvrjOC9N8xFWNSWcy6EcO19Q2WkrPHcGrMfE
         XrcOJs2BxUwXAveRarDCVFvRuGM+3ooMj5CtJgAzioq9U6nFtxk8ezOGoh2GOKV86QpU
         zQ0GNxV/xvAqya9G/iXypwa802cA68qx3Ib0SWJd34l4E1gn57jR/zvVUKNqOwz/0MqM
         0iHHTKM9H2a4bVmUgepubbHNSMA+44A6CqjJWeLkthsbjBJzbkkQ9n1Z5b+S4/gj5J82
         JlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732163786; x=1732768586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuyF7+8Fz7Mpttrs+fI8NL75TsOEWtX+J92XFGbgaKU=;
        b=XZ46jdO6Y+zz2fRZGyKbL4qOwEXsH+Sgr11dSZm5UrbSSI8Gjaus0CLJKl529qTJwe
         akwV0MQj9ILMbidmg3JSWi0SI63c5lQdijvUtrMr2OoIqDxajfn4x8cQD/pXybk+Qi7Q
         UjYWrapJGMBovKkBKh9UJW/RSAancUyST9HPW9WoUAknHNuDclZzQ0Rk/1ZwCY9FhfRI
         KlGPawvYRPAX9Rt1GT59/2Eda8zmejLsckYEqJslyprZUzGYZhzN6br9785QbgxT9U6r
         pSmECCdDuzpFxTyzZEsXwsac4uhQKB2hwoH5KutXlBd+rhyYB8Pd4jmTKN3cx8/COPj7
         sFMA==
X-Forwarded-Encrypted: i=1; AJvYcCUvw0OTb0jvdFbmZ+bVFvdLT/HMVd+7S9aoWup96o8iZBKnvQZKQ4PXfLBNS/5jp9mNSSQFku1QjnHBLvc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyh63aPBsaZNpe7GpYNYGPq1pxLtgN0zHG9dlgTq2GIjMgw1m+T
	XAe4eC6X+dyXLvWHcxOKgSLcE7zFr70EML96gvSsuXLOjHBSFtBC
X-Gm-Gg: ASbGncuiyVPjr8MKfdbPvTJz3cRPNSIYWth5FhYgWxbKGfMKIYEaqZsO3CvKsFaxL1S
	Wc2daFO2TPLAQ5kVFdDRhWvB7CLH16KgG7CNNAsplnMXG4go2MDVxOU5sW6+iHQW43nmJNRQJQF
	7S66UP2Q9VsHgLtV7BIn/faxwZgXo7Zwvf9/ouWjaEtWKtLvS/xlMsQURTH4TpA/XKIapoyK+8h
	5CU22VniBFEiNNq82RzMZrbn+PLYuDD4o1ANB1sXKqRuw3kma+OtEa+2JF05cyrPFR6eb7P7oAt
	Tn4Q2JbVBox+f51j9LeZfrBM2y4=
X-Google-Smtp-Source: AGHT+IF30ME5s1gaJATBRjBcX8Rto6d8Elgy0z54nRN46cpfTIYfKGmrsKdWfd4s/uRCQcRBSZkQDA==
X-Received: by 2002:a05:6902:2742:b0:e30:99c0:af7d with SMTP id 3f1490d57ef6-e38cb60dd1fmr4909115276.52.1732163786614;
        Wed, 20 Nov 2024 20:36:26 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb64e11fcsm402013a12.15.2024.11.20.20.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 20:36:26 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 21 Nov 2024 12:34:04 +0800
Subject: [PATCH 1/2] ARM: dts: aspeed: catalina: revise ltc4287
 shunt-resistor value
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
Message-Id: <20241121-catalina-dts-20241120-v1-1-e4212502624b@gmail.com>
References: <20241121-catalina-dts-20241120-v1-0-e4212502624b@gmail.com>
In-Reply-To: <20241121-catalina-dts-20241120-v1-0-e4212502624b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732163781; l=968;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=FgpAIoX+4e+QQroE4QsDxMK/L1w728/CM4HFCE+TVtE=;
 b=BICNuLr+vifOMwP7TqOnU1nthYmDGgU8Prg5w33jLmWC6dvW4VwWc/9Zu3wGhVdjBIjx0EDd5
 qUdPwWFlLp7CjHJHpQKpOCBj3RbEa9Xfty41tXlgOVXDhtTrMhVEUOJ
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Fix wrong shunt-resistor settings of two ltc4287 nodes.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 82835e96317d..417c0d12635c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -512,12 +512,12 @@ i2c1mux0ch4: i2c@4 {
 			power-monitor@42 {
 				compatible = "lltc,ltc4287";
 				reg = <0x42>;
-				shunt-resistor-micro-ohms = <200>;
+				shunt-resistor-micro-ohms = <100>;
 			};
 			power-monitor@43 {
 				compatible = "lltc,ltc4287";
 				reg = <0x43>;
-				shunt-resistor-micro-ohms = <200>;
+				shunt-resistor-micro-ohms = <100>;
 			};
 		};
 		i2c1mux0ch5: i2c@5 {

-- 
2.31.1


