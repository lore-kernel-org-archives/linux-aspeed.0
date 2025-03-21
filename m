Return-Path: <linux-aspeed+bounces-1104-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C05C36000
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Mar 2025 07:28:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJvFG03vrz30MR;
	Fri, 21 Mar 2025 18:28:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742542113;
	cv=none; b=Nap0cS1iPnfreEYSvKr1u1swdG49renUTXgLNjTDjpry8Eh3Q/uxytCiO+74gYkQc0DUTekZVyrIFbmDtTPJT7Yl3WzFxnr5dfrdqkhZJ6uewsRVl6QUZt6+t3xN4HT8F6I2ri8OOKMBQZ2ab2utkN/Demx7c5iqyAgkA6sRczxCX9fjnZ36rbYDudHSXDbR4HM/jt3hKD45J3z/6hM9jT3kr4NEHOWFrWukqQNrxJuHdZasGyFWAFN8PzfKfeB38wSRT8Wx4/thkkY4dSKyNyvh1Ndc/eXtVpwDoQ/1QsVls3whfFyvgfjWD5yogrLVDpXolaesrkF1GPic0dszWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742542113; c=relaxed/relaxed;
	bh=iQ6AZvpz6rhEfIMNob1PWyEst8krux8q3uqPjk7Bggg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QyZt3cvmphGU2krOciUifqvNL/4TiHJ/PQx2U2n+5HPBKhDiskpo7o0zj7ZOiWfzl1sURWVDvKJO2T2Jx5juEio0NydfL3fF/PGhd4ZpH7pZWoXkYc4bEhXd2iTkOxSqETM4jH7QxCHu4qlitVVe4moXCozd0rQSqi4fvXBUUHxVWhPsnKryrZ/Z4FKLqw+jAT2/RBBeibxUrgd3mptLrXftIP0Ej6zG7dwZ06YG5fPkicMcWEYreiBD2sIvgGu9oxTUZbo2DPtE9qhbGN06k6Gx4LmIXK1eF2BiCP7UxegHCo3S28Rk5aOebMxP0lvh8fgSfQGcX32qiZdirU6qNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bckSvS2J; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bckSvS2J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJvFF359Pz2yrS
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 18:28:33 +1100 (AEDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-225a28a511eso35420785ad.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 00:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742542112; x=1743146912; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQ6AZvpz6rhEfIMNob1PWyEst8krux8q3uqPjk7Bggg=;
        b=bckSvS2Jq3UnB8c9ekQQqOPjvNOz96sLtyrm7fXbXYn1Isj7hbFyQHaG8H0FnvEqw1
         wbkqLwSSrxo7tnnbi0N+EfO4BE3j373uJMW3MBbT38j54KnU0n8FLUQxCb6RrDPJ5m3G
         sK1QVVagKBOSPdsCzvDXDFumXY8H6JTkb09nYOOfTw44iAdpDGVC8QnajoWUpfgyeopG
         7+cOeTcAtHgnU1865SyjrxZILRMk+Cw1i5TSujtfBD5JdKD7mlBJUvCFCN+YH5jPBFa5
         /OZPBjfKFT0Xd0KGtRsYZl/+nv2elJS5LfArCVZm3o2EA08nCruUbFAQRijcjSZAXHwY
         dL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542112; x=1743146912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQ6AZvpz6rhEfIMNob1PWyEst8krux8q3uqPjk7Bggg=;
        b=caHV10vbWLqEQcZmfe2wtg/k0dS35ceERRpq6hEgZ/73N57iYJs0KX4tTRuIhi86II
         Hb4Xbi3LbbEKeFEWKhODL+TNc2Qc1DK83V5XEljtVGQMVkC/zuhjNcsRH18VQwcRwfwt
         K64CKpgCyXVmgURLBWrB9iB2gdO49IT5q/39iJeaLj7r8nuw5ywKXeijYj+vbjfc4BTu
         7O3jTViHkMTzfENS5GJCbdUYao5b1IBo6olRLzMXMtSwl6GAdCnS/N24NZIMymh3fGAf
         qzm3N2Ip+NfZb3MCN3v+Ce/v0LqMbwN/wdUPxisTfdHsDr52jlXNP5QTTWe57+tE2Irg
         hByQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi6FDmGdkgkU7R3tpkNVC/1d5bhA6nch2T39c0ioKtI4PAE4S2p3+eATF/dhz+s2GKol61B6bX4+d7/OM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywp+4A/C9Dn1PC7IxVlhKHfNcT4wDAQEYrmemgL+rHN6ga3Yi/W
	y4YKzzXvwohkDjH46cPjvAoFThGFeBWxXGHFr6oPuNvu9diVBGei
X-Gm-Gg: ASbGncv2w48L1Ab6MG1QlV26W9ZK9Fx+Bdo7q6fHFGXT3k+ChEvTElo53XPMzwojaGr
	eBrde7LwSse3pFVnf4Uh1hQHdsZs+BbbfD0YloNeX0rJ0H7k9U54grKAgbOG+1l15wbNVGAXo1h
	LkxPl3Tzr2vtr1nlb9Ap5BFNEUsi/M2pME0vYwI1CqCxcPXdRuIh6d5Mu8HhrtGYG4rDAT1C0Ck
	I1Smvmr/e3Mx400f/ll2E//5udEglJ18AovZ/4mMjDtSG4f0obrQPoJZnuq9VmKcnawxDQvWKdq
	f3tdeTLFLKphEDkgqHZd1WGSSGZa14Y1Tc7TKSLdfwN8FUxlzKOitUoBlkLo3B1Bx0SShA5UkFq
	3a3WHtlMGkSEroQDEhID73Q==
X-Google-Smtp-Source: AGHT+IF7FqBLTpoqu0WbqKOuE+QLRcd920+js8xSlAK+76OhtVDhNbPYQwPAH2OcbN6qA0DGpJLXxg==
X-Received: by 2002:a17:903:19c4:b0:224:912:153 with SMTP id d9443c01a7336-22780c546b4mr50211195ad.5.1742542111611;
        Fri, 21 Mar 2025 00:28:31 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f396fasm9862265ad.27.2025.03.21.00.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:28:31 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 21 Mar 2025 15:26:03 +0800
Subject: [PATCH v6 02/10] ARM: dts: aspeed: catalina: Add Front IO board
 remote thermal sensor
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
Message-Id: <20250321-potin-catalina-dts-update-20250102-v6-2-4bd85efeb9b4@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742542103; l=882;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=P26V4Vll3LYpWjYPKGRYB+hCja9t6ZA02VGXue+Ra5U=;
 b=1jyEURlt/5++JQucdIxsVJF68m7y51O3IBeyOync7w+P29hPHxy3fEcN/cXhDXvIy+QwRU4Q8
 AjZOawK25tpDUsS4J+XGCbz04FMJf03ZVOY2JXgxX3inZSerlbJpg91
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add a remote thermal sensor node for the Front IO board in the Catalina
platform device tree. This sensor enables monitoring of the inlet
temperature.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index d5d99a945ee4..307af99e833c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -544,6 +544,12 @@ temperature-sensor@4b {
 				compatible = "ti,tmp75";
 				reg = <0x4b>;
 			};
+
+			// FIO REMOTE TEMP SENSOR
+			temperature-sensor@4f {
+				compatible = "ti,tmp75";
+				reg = <0x4f>;
+			};
 		};
 	};
 };

-- 
2.31.1


