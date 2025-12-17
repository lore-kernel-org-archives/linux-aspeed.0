Return-Path: <linux-aspeed+bounces-3125-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5DBD6406C
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Dec 2025 02:43:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dWJ563L0lz2ySV;
	Wed, 17 Dec 2025 13:43:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765939402;
	cv=none; b=Y07NRXepUJD8c1mKaysZ9CWXD8SoaR+fLegEN/mh0SG3ocsEfB6mKa0eL6bLRBPUFTaeI7tX2vRLmfVUYVcCFPYqtmf39/w8O+AaTdZD0smRshyEYyOjG+kJg5wb3ixci51j5DcRIgXdxTaIQ7p+70WD1rEnK7+6a5jYIRRdpLBCIzM2UYXHJAu/ImpaWbq6VKUH8qBgzYGVpsTaffIdR5SxJh+jsfbSS4Sj/AHaQcAeOHOQ0pUULkgZaVC9RKezIfd5MKOznXSzUAcsO2EKicWWxg6OuCIXRSvJapmFyIU4Vi6SqVBK+C/tO4VY2Cu2hUWtx8Po5WoFMMPa8jyNXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765939402; c=relaxed/relaxed;
	bh=SXY85Uw4s718bBbfWJ62Db0PnAMMSAWmGr9NoDA95ks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WmOpID2sFijCLjmpmqIaCI8k1PKUt3FtpTzkSMCgaG/jcqnF1Agz2qr4ZM3F+kB/jAzevWLylWnbiSNJ9f0NXjTmwDeQ7rOxM4jrzMkYdU/5xP3vPVfKjYZ7oewZvMvaK+aAbvyo3x8BntqT5uHWhD5cG9/M+wdO2wHqJWYGWETYSFzdhTDawhzFK99RKinzbCfAxXtB0a9nYQZbkjVhj9uQkpxAjyxk5optM2SD6DH4CM0zzvFde+aBodSu0Y6UlaRW0UiU7s3s2mY12oAQXS7TWGXMkkuFy4xyFCmDOfhLztIzn3G7RhyvEiUG+XES9VTe1jJp6qovDSzpk7Rtwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NhFaHuyI; dkim-atps=neutral; spf=pass (client-ip=209.85.210.175; helo=mail-pf1-f175.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NhFaHuyI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.210.175; helo=mail-pf1-f175.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dWJ546LMRz2yGq
	for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Dec 2025 13:43:19 +1100 (AEDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7f651586be1so67063b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 16 Dec 2025 18:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765939337; x=1766544137; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SXY85Uw4s718bBbfWJ62Db0PnAMMSAWmGr9NoDA95ks=;
        b=NhFaHuyIojX4UL8nUHqoh/up09jpsHN5wFpzLc5MVISOP0eu0/a7YAk0+7d+o+jH6W
         GiRGuQe53BMjNGQ4u/BmvS9lK5YtLXr6Y/UdcHDHuwBmsr3AVw6haGmxukDWf52e/DNN
         ZPdhp2xJLguRagIl7WnMsxxTzUkdopVgsMQnluIsCAODuwfIOHMmNXRhoMFFiG447aJ/
         nkixQIJQ2pfP/NtQd8OBmOYKcsh4he2wjI8VNqZo5/pKAOHGvoUJ2ueFDuucdOD0VEMb
         KZg+acOYZ3jAzpjIL/Ca5D/pb+Gom5Z3TbpcGea7k7xiAFISWQfQ4O5GzPMmuqIeEbiX
         j9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765939337; x=1766544137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXY85Uw4s718bBbfWJ62Db0PnAMMSAWmGr9NoDA95ks=;
        b=pblcOU9/A/rj+TUceZo/2QGdCGVC/Tyh5/aS6xsiQZNydvphDDrkXymWkL+HjzttGS
         so64fXcUDv0vWLML3ocx4ks29SslIE40OILcTWSJnoV2Qc+xsgvU5Yd6ZC0p5gtJaAI2
         Z+0dnPgUe3OEw6OruU3u64x27zw0mcYAiJTXcav74d5hObQkuMMhUCnMIpvz5G+O1zou
         V79148v3FNxaz9/O3Sg85JW75nrmy1nmYA367XyM8nqHSVgXw2JmPfNS5lSj0Oo9vFwx
         zqPjc98Bqrq5mhfplsBM+TQF5RKSCeo6wZmtPQYlvtmc5X1W5IhrrFodn7J/gdrrphaJ
         0EpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQbe7ndN6z0FUyZaIB2AEISUqfFrFk3TkXIjYMKFVRRW3mgfgRqzbBDEvzE5/MrjrPhg9/+TFjytViXOw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yytja7dVS7rWTh5F+B7myKMVJkHxp7Z9UOKutrgvLdnOAE9U+qU
	FS7a1rCdCcBIS6BWExX9CbOm3RROzC57ywnfIc4i53OnYdIdnFOUsBR2
X-Gm-Gg: AY/fxX6s9freU9FmuArYJqFcC8xsaYlvkfoWvqn8KlyRn5LFs+z8Lq51UU0wCYFckWz
	PvcFQR2a4jOdUojgjtlMkByMM5Q81dtdPvBnsvXsmrXfR4Xcer37mJaMTcfgZsEABb6etfwnhSH
	6wTwBEhLMlnGjZyMkSA1JdVXJ0i4gCUDLkRsqlQlNDnEwA33Sax9dst5L0VUUxXoIrZVBOmGMt8
	At6lspj2BjQmFFCxPN6a7AgCKEDBNhCIMAUNbabR4cW+OvMVBtBPv4Ci3mTuyN0UmPB5RjdC6uF
	9bBhxDkVoZK8IWpzRZvuhulWxgOfcd6hnLYOMf0tYOjziwN2FOETA3Rsov7mK38DKCvHeBXCMnI
	wxwEyyKm03+yswqhBesSO9iiQ8w0CGXa9ixhYGWQCdoLpuEZF+tmMqYdfWLhfFuzv2yvLYtiDm3
	nU6aUm7rFtEOsfrl6OKRfvAfIbb4sTOsoIV+txk8w12cBbMvrLNKsx9gtM6pPOkdNE7FgjSUZP+
	Mt4tfPPc0P+G+Q=
X-Google-Smtp-Source: AGHT+IHsL7dhoNmgnind5e824EvL1VoebSronNRlFQj2ywcoJod8TlpwxQtVbzBWrHsh8omPPq5EiQ==
X-Received: by 2002:a05:6a00:330a:b0:7e8:3fcb:bc3f with SMTP id d2e1a72fcca58-7f6691b4951mr13932466b3a.20.1765939337346;
        Tue, 16 Dec 2025 18:42:17 -0800 (PST)
Received: from cosmo-ubuntu-2404.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fcb8c29738sm941342b3a.17.2025.12.16.18.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 18:42:17 -0800 (PST)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	cosmo.chou@quantatw.com,
	Cosmo Chou <chou.cosmo@gmail.com>
Subject: [PATCH v2 0/5] ARM: dts: aspeed: bletchley: Fix dt-schema warnings
Date: Wed, 17 Dec 2025 10:39:33 +0800
Message-ID: <20251217023938.445721-1-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
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

This series fixes dt-schema validation warnings by using generic node
names, correcting GPIO property suffixes, and removing unsupported
properties. No functional changes.

Changes in v2:
- Split single patch into 5 separate patches by change type

Cosmo Chou (5):
  ARM: dts: aspeed: bletchley: Use generic node names
  ARM: dts: aspeed: bletchley: Fix SPI GPIO property names
  ARM: dts: aspeed: bletchley: Remove unused pca9539 properties
  ARM: dts: aspeed: bletchley: Remove unused i2c13 property
  ARM: dts: aspeed: bletchley: Fix ADC vref property names

 .../aspeed/aspeed-bmc-facebook-bletchley.dts  | 100 ++++++++++--------
 1 file changed, 54 insertions(+), 46 deletions(-)

-- 
2.43.0


