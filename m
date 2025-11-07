Return-Path: <linux-aspeed+bounces-2835-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A30BCCFA05
	for <linux-aspeed@archiver.kernel.org>; Sat,  8 Nov 2025 04:41:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d3NYH6jglz3bfQ;
	Sat,  8 Nov 2025 15:41:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762503144;
	cv=none; b=NbP+AGjFZhPCTpE/Be7FUHGPVKuWT8DM4O+nPAynrvP6wHkoqxdnDUovj7mrtDSmyOwEVt0hTnSf3i3GLaTKMp4Dwn2alwgH+YXnLVXCLzOPWfl2/TQoBm9XhVAs5d8CH++9tEL+aIpwuutlGkhglX4TtdAXNr5ecae6kzxCNRhHi0LRbxNTkr1+BLCNYd7RHBDn7Jqi0u3tUe2BtMeMLu8GINab6rkSCr8S2uzldniTpZ0lGDhjm+hfF5V2nnLD6SENKn0+76t9zi6sD3a8C9jYc6jmn0Mqoiy6aPzAdhA0qJbrHGwskyXdQ7TdfocoKkwGM+024WQbBWKQzcczrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762503144; c=relaxed/relaxed;
	bh=Dmw8BUMis3U7evEGAA8fT1j+khq5yYTTfzGiGGo+D+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kncl6MA4mQO+5kTJYM1e1VtgsoHh6EiRJR6KG4ENl6i34lEHdInq9udHxdFv9jKC7HxC5P73gRr7NEf7xzK77qwtHSTJgR6mizDXqAZ56c79mS3cyx5Lzv1fA7UpHKyuonOiGCUetq+PeXL2p34cHpQPwuzLdpPhbESIuf/8r12qn/aLBm4HWeLdvauoBtNXvxtSZxGJ9Mpr2wwwr1quX/11GODMfghUShMVUgCF7JOAcgEUnr2bC+oPJKPH4I2KaXDTWoSt99r+I4wUy64fHBLmsijZWSLIaMf4j4DaZPkXsztN3FXp+Aiy+3q8rG3sO18n3erd54Zr1Dgkot9xLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Qgl7oKRq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Qgl7oKRq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2sHC55w7z2xPx
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 19:12:22 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-330b4739538so463876a91.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Nov 2025 00:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762503140; x=1763107940; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dmw8BUMis3U7evEGAA8fT1j+khq5yYTTfzGiGGo+D+I=;
        b=Qgl7oKRqBeASkoZY47P+B5Q1s9fWD0bDHGVs1whEYRsyKc+xDIoQwi1baO67TUAV2n
         zNzP5aPiHgue+9ZW0LMHzN4a2M+3rnVx0oGFiwNoDDmP1ODi1yUYnC2EVytjxSR67eMQ
         yQZVUat3KHGq1FBdMpfWpyidfquTZRem46A+umyCrgvd8hBU1D4ay3AsFtjnDVOx4SEJ
         mWsNNTDRKoJLT11maxD9wtSjgRaD7vK3A+ybmkWOnVh6glWbJlrbPtoOc5S+2/swtWhe
         aT9lFuJNj2uIgVoLO6TRmWSl++fg91pJw/3iBHpneFHUqBwWIR9grtxg//gaue1TyTgR
         EfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762503140; x=1763107940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dmw8BUMis3U7evEGAA8fT1j+khq5yYTTfzGiGGo+D+I=;
        b=jUow8HxWyPGxd5A5l1EVU0NWk0Lu4UlusgU0EUcNYxw0qtthrSLXu+23hZBqyESAtI
         bkGRL+KxP71bo/Eur3uGuNPpbPNqGfMgtWqj2wlvUxJw1krRNVhQ40CWeeDqVzuiw9w7
         RMMBG6t9k5iWGirwuaTDZFFWsR6rGCi3/ODzgXoEvQQGNaLc+wg5Ndu3NEHvu73D+cM3
         BVaLjJlMpAsxn5IHEUUic8CJycboZKCsFEPkB+QBJbThs9qB3sHVFCxIVr3vp1e2Or8C
         +aE0B2xVwyw+64XtnAKBQGIIsCEIXkuUz1uMm+NUFz4m6LjZOtecgc78UDvfpTsOz4H8
         1Yaw==
X-Forwarded-Encrypted: i=1; AJvYcCWL5BiD4YeeLeGHo5zBJaFDRo41BPojJSo9YRca35s7trh8wOqhSZpA8su6q10V5reCmyVuiaMZspFuink=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwJ1ObEXY9m63OKazohiNFxYg3K6HNYRGsX+s7PdTX1cdVa2PoI
	k50JmTdZYbMPHFh9ArZft4c/QiCN0E327iW08l4ALGppihIhnjKYIODS
X-Gm-Gg: ASbGnctApOEcP0mikW5W0f1zeVLpgDdtvvPh+NOJNl3D+8J7NsUJu6J3X+Ie7Jg9WYf
	SOh3SxK7Ncrpiw/ioIjdSxWO6MLZfSY0vOB9W+kdCxl83QGjRRuXFqOw2BA2MwSWIkzybtq2FB1
	gw0xpVq8yZrRfajan7GM1hsReNS/ckEWHPv7DNc1l3IyzWmAGqX6y7JHAX6nIVCj6FRDymFbT5I
	uXejVTNGk/45A07ZNq9Ld0NYuiMEwkplAryuBuGL5pubQgYxucBRMSAKFmP8FbxrRMqgPS+pGSa
	Xco2C4pVMEoGm7r6MbqK/3ma8hmusDqiZMkoU4IPEN7DDk9EV75kdoo9IFu0v4CJqMl9Z1QhQs2
	h5uESI1SfyIw6dk4q5FtA9lNxc7hGT9EdjO2/cwtYaaJg84guB+09Oywfx6kfvRsMIP2n0w==
X-Google-Smtp-Source: AGHT+IGs1b/E15BQQr7IRWhnvMwkUWjaQl+1pAkJ+WBKp4CDaO9Vgbztv4Mt1ZD4fKUVL35oC8br3Q==
X-Received: by 2002:a17:90b:2e07:b0:339:d1f0:c740 with SMTP id 98e67ed59e1d1-3434c4e4544mr2792443a91.1.1762503139944;
        Fri, 07 Nov 2025 00:12:19 -0800 (PST)
Received: from gmail.com ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba900fa571esm4450338a12.26.2025.11.07.00.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:12:19 -0800 (PST)
From: sjg168@gmail.com
X-Google-Original-From: peter.shen@amd.com
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Peter Shen <sjg168@gmail.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	peter.shen@amd.com
Subject: [PATCH v4 0/2] ARM: dts: aspeed: Add Device Tree for Facebook Anacapa BMC
Date: Fri,  7 Nov 2025 16:12:10 +0800
Message-Id: <20251107-anacapa-v4-0-peter-shen-amd@sjg168>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104-mellow-denim-dogfish-4affdb@kuoka>
References: <20251104-mellow-denim-dogfish-4affdb@kuoka>
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

From: Peter Shen <sjg168@gmail.com>

This patch series adds the device tree binding and the initial device tree
source file for the Facebook Anacapa BMC, which utilizes the Aspeed AST2600
SoC.

The patches configure the necessary platform peripherals and aliases for
OpenBMC usage.

---
Changes in v4:
- Addressed the fatal 'Broken DCO/email chain' issue reported by the maintainer. The Author and Signed-off-by fields in all commits are now unified to match the sender's email address (sjg168@gmail.com).

- Addressed all remaining checkpatch.pl warnings reported against v3:
  - Fixed all block comment style warnings (converting to proper multi-line C-style format) and line length issues in gpio-line-names.
  - Removed the un-documented "amd,helios_cpld" compatible string to eliminate the highest priority DT binding warning.
  - Removed unused and commented-out device tree nodes (eeprom@53).

