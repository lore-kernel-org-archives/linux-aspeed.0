Return-Path: <linux-aspeed+bounces-1109-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C1EC35FF3
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Mar 2025 07:28:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJvFW26YTz30MY;
	Fri, 21 Mar 2025 18:28:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742542127;
	cv=none; b=m/vd+VVSO+2nJJ9iBwMoXSjPe6MyTq39Dx0ZEH0re2T9Va0Q9W0YXbaU6V0np6iln4ySnuQbrUvMUC5Q7aVVnsCOsHvVAhwSVNOnTSpwzXH1la8Mdcoe1r5QsBvX3ZQDfqVT2hy9OgoeYOowrlTXPuuL2HaJgFgnW0zck37rtcFTx8Ck9PtsrqxM2S70B8Nqt0jsYyPIW9s0I0V1ifwFzZYDov72wAj5i2F6PCaPV3QllJ0atRJOluF3n8e6vRmF0SHeH/AA/LeTAFbNyJfqc2r5n1iKjeRQKBFIu+muknJcXnGGxeymp1tYGxWzDl7berNaESDwossIqGfqFfFtfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742542127; c=relaxed/relaxed;
	bh=ZLcbKMhYk8uxEh3mrmQXm9xuYwIoSY7sWCRiQyf3y4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Me+DwoTCDqWzzMb+90p/0sOVTU3W9DKfB4pcy4BG+YudeUzkz7vHMKPEvoAVsWlbj+xNPUv9FZV4COmIcCeiBZ2fLZ+UyNhtaATLDXjaijoDNtXgSFyBsMKkct/9lxN6R3faSbPG1T2TwmN9QZ2baBfWBI9GPHYyDZ39YxzJy5d1XojvH+bGPupuXjXMXdI3yGTK4/+Y7MsczDP7cyNP6Lu3+4TfsZIjYPwa3nEg0vjle+EsCoO0kbc8oPMPuKtpL0emd5T186lKzVH0aRCzJBje4vaA/3Qs1hwQuyuH1+qlAlw/iMbqxDL1eo0bDrK/qI7LRBrfEZ8DpbXR3i0eSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FyxvFHpZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FyxvFHpZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJvFV3s6Dz2yrS
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 18:28:46 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2264aefc45dso3695775ad.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 00:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742542125; x=1743146925; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZLcbKMhYk8uxEh3mrmQXm9xuYwIoSY7sWCRiQyf3y4g=;
        b=FyxvFHpZFlolWcZNFPMC+akC1yyvDHdZDQ8dVkVeOspJ7Qr5NLrhUv0Duf3eWWl/RL
         E6Fc0biG5rmTMFTKszFMAGcyZOxwnJIBfpuRF2C6eRiiZP20V7c62KlvFxJMpho3rtDR
         zsQYXBpSURIiyMjcB36wpA1OvITZ5VxF2CB7Aghc8Plj1jJForVCoLHpT+/O0BEpt+Pr
         j5FULENpz+l2j5ymJIhiFxnp2m3QmAK+3X5ll2yZbdUXw1LBooApWOiSrVKDtFmHZkX/
         QsbxZ90bkGoUj+YR0mz3UUwfWICNOwZ5NygwsoIAHM3PMyaxtRWGzyPF5qAlizeyASTX
         G2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542125; x=1743146925;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLcbKMhYk8uxEh3mrmQXm9xuYwIoSY7sWCRiQyf3y4g=;
        b=cEobhfwyDWXyTcUaUF7A36TJJCyidR8QIyGxcGtaShbfrlwCnGqqpG8TSJ1Ortj6l/
         Hw9ehvOe+XE6DqocODDgvRCW1JxAR42hEaJTbm5OxCPuqNE8NpUBWi0V//RIWh9/fouq
         Kh7gNHsC7iI8z43Hm1mjtIgBdkErOjuy6pcgBl0DfPhLQFLcOgfNEmBzGvyQxS00GiUo
         /2JWO6+kdA37AANpZvhm3GDsb+2VcUFXL+yGJvV8DxgoK3OynOqVQHZRKWZqOwzD14ft
         1IVRilmY/Eqwjb+mKcncc+mm8DaMxpFWFsEu3Qd/Nsrw8XG0NsKdKom38QaltRXROnEu
         Uqxw==
X-Forwarded-Encrypted: i=1; AJvYcCWamw4+7BMT3/mjjkHqQgoXhZLao97IMcj5DztsRM787H38IaAb4HpNC60PS1ip69DWzTF5OXkacDm8PHE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwLm6V2dY2t6v+/dDN3og6FiH0aXjRvp9hpu3cQmjN6TjmMkdc9
	/1pxPz6EkN6/QMgtXAYcsCIK6/BW3KnMIDBVkOYibGtgYES4QzG9ctizPA==
X-Gm-Gg: ASbGnctimg6fCb0r7W+QtcUGlbc+7OMPFlBJKUUgb1UWQUbvodW5q5OhS6Abh0qujg3
	EqYLogw0uji9zWyuY39fIjDbyetwSX55xSbionZ/yrif1jhjxUEbiATn07Ry4HMeS+9nF8N93nt
	sMhN+qgUrr4uEmb8T6O1VlQMkzs3cSch92aHQ+nIZXZCXyFzKDT/cSrqDiGQ8KD/LodiEviLRR6
	dHoamgddwchjPbUCCxIuoO1GZlp3HfJJtF/gIHO4dDXHUDAdfFAI8s8iUn/pdbg3D+XbptUYR/k
	53fYVl8T2OI5OUSEdJGZAMSPKR1pHgze8JLivmTzhRmLL1Dic0BiiPLK9TTxo3tB6xz2X15ZOey
	FIxry4veTi6M0HDnkeY1pBg==
X-Google-Smtp-Source: AGHT+IF4SxgsnT3zZvci0/PSg+6Xigby8O/vjqm4K8plyaDY1Gq1sOSCHgwXKkuKrYcIMeMR2ARBvQ==
X-Received: by 2002:a17:902:ce08:b0:220:e5be:29c8 with SMTP id d9443c01a7336-22780e08cebmr41057985ad.32.1742542124465;
        Fri, 21 Mar 2025 00:28:44 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f396fasm9862265ad.27.2025.03.21.00.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:28:44 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 21 Mar 2025 15:26:08 +0800
Subject: [PATCH v6 07/10] ARM: dts: aspeed: catalina: Remove INA238 and
 INA230 nodes
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
Message-Id: <20250321-potin-catalina-dts-update-20250102-v6-7-4bd85efeb9b4@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742542103; l=2083;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=sycCkrcM+LJ9UbAjzsXD//ULjcrkdN+dexyZS9F+cjc=;
 b=y0hZDVQSCXSdKICSxhMEFFSAzXsUl1jHR1wnRdOkOfCt4z606ExaBcSEhg3Tzf+RlwFrf4eTv
 +ipSBlhcpZkCH4nIMLqR08XgykEPCqDxbSAwtV/ri+dxAQqz/obeh+/
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Remove INA238 and INA230 power sensor nodes from the device tree (DTS) due
to incompatibility with the second-source ISL28022, which shares the same
I2C address.

Move the driver probe to userspace to handle sensor dynamically.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 45 ----------------------
 1 file changed, 45 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 306931c08cb0..6702be32918e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -432,35 +432,11 @@ power-sensor@22 {
 				compatible = "mps,mp5990";
 				reg = <0x22>;
 			};
-			power-sensor@41 {
-				compatible = "ti,ina238";
-				reg = <0x41>;
-				shunt-resistor = <500>;
-			};
-			power-sensor@42 {
-				compatible = "ti,ina238";
-				reg = <0x42>;
-				shunt-resistor = <500>;
-			};
-			power-sensor@44 {
-				compatible = "ti,ina238";
-				reg = <0x44>;
-				shunt-resistor = <500>;
-			};
 		};
 		i2c1mux0ch1: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x1>;
-
-			power-sensor@41 {
-				compatible = "ti,ina238";
-				reg = <0x41>;
-			};
-			power-sensor@43 {
-				compatible = "ti,ina238";
-				reg = <0x43>;
-			};
 		};
 		i2c1mux0ch2: i2c@2 {
 			#address-cells = <1>;
@@ -753,27 +729,6 @@ i2c5mux0ch7: i2c@7 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <7>;
-
-			power-sensor@40 {
-				compatible = "ti,ina230";
-				reg = <0x40>;
-				shunt-resistor = <2000>;
-			};
-			power-sensor@41 {
-				compatible = "ti,ina230";
-				reg = <0x41>;
-				shunt-resistor = <2000>;
-			};
-			power-sensor@44 {
-				compatible = "ti,ina230";
-				reg = <0x44>;
-				shunt-resistor = <2000>;
-			};
-			power-sensor@45 {
-				compatible = "ti,ina230";
-				reg = <0x45>;
-				shunt-resistor = <2000>;
-			};
 		};
 	};
 };

-- 
2.31.1


