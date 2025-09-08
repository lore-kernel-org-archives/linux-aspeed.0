Return-Path: <linux-aspeed+bounces-2177-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD6FCAC582
	for <linux-aspeed@archiver.kernel.org>; Tue,  9 Sep 2025 00:34:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cLPw32ncNz2yVP;
	Tue,  9 Sep 2025 10:34:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757318549;
	cv=none; b=LIihK6gzJa4OZ2VlrahV4XtDzM8tLEHeUa92AZBJDOiO/OrQCvRxCnywQ6PDy2K2iN9QMFyu5S9R5XkrvKubVmQEIX195l/rAMhk5VCh7PrXnfvo6bSecB3fPa/voxP/jDVlrG4Wf3hiB8xanOTGqWM6AvJtuLB19IklDIJvzqmPA2Z0hkGNeeHE+dez/vdplprbqGzOX/KMj5RNYURFRRK0MJWiUpcJ5yj5WkmYmAoBLna4rov1orxdvYR+WiYl3d5hMhQUl2wgULQXOnT7W8bkVWhXIlSyo7nT6l6Ut1w42mVlHYADorUoO0MHIBoWnsbF3l+bHVO7iK9q+fDP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757318549; c=relaxed/relaxed;
	bh=+GK9tSWxCSwHclhCGlVejFXBQ2aFQkr+nMXMBqRXK58=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IZPLrCjVxksGWXcpfsveTzqa1+BpiBTnETQU+KnWhweNnbFoL7iR4Qrc2A4zXZJ94AhE8PL6B6B81KlDn1v4yGidsbxZshqys0CHRwmidtKSUVChwcz51Cv1T3RRo59GKs/HHYYrku/5Jgh4p8XgN+4VOMSP3nY1mhupySt63EoL0r+owZJr/Krbc1TNRiapMvk7CnEuRrH/3ioH90xSzNE6Kv4EAQz0FyQ7DC53nS5C4DiRJM1dOW5KPmjh33JdxIhtnVR/qWbKY8SWUA/+TXDvOgIJKIOd+E0UqhfGYW6Bqxsta1QMs8+XVbQRHuURH4cSwfeeM5Pu109nl07/Vg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hjgwQoNY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hjgwQoNY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cKzvS670vz2xPy
	for <linux-aspeed@lists.ozlabs.org>; Mon,  8 Sep 2025 18:02:27 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-32bab30eefbso3020284a91.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 08 Sep 2025 01:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757318545; x=1757923345; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+GK9tSWxCSwHclhCGlVejFXBQ2aFQkr+nMXMBqRXK58=;
        b=hjgwQoNYKzx/qSY5FBHsvwb1ZgUHKslKKDc6ppm/V0ZJqO6VJ2mbL+ONQ2eLERu5m8
         MhMaDlAvO31aNCNSU7x2GFtzcQfPZWj4VrtwsafUqePEbTkZggGOmduRuaHp/rLuUmAn
         GH833mlPRYCPEh/4AuVWiLoffuFZ1jL6D6wqx7K05tcVtLMzRF8VNcbqNz5T44s4FBSf
         h0veYPtv/wnjT+X+oXwmgHWASNF8B29C/zzhtCl/04odbLZztCsGBBDeyK8YPczO9wtF
         Ba/GIQJmIKX2VOyi3fpgT0nAgbiej0MT1gz+zQYSL7c3c142voTESNG3pG9tAdCeT+As
         LVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757318545; x=1757923345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+GK9tSWxCSwHclhCGlVejFXBQ2aFQkr+nMXMBqRXK58=;
        b=XpzlglCgzBQyoWD4hRSjFeF88NbNqwumIvnn0jm+zLhgq1+Fkj1/2a21FJIYJIWPDz
         Ycph7VqtSLmHFEcSIpNWEh2pE5aMlDsUlvbY9jEwNslMVo6KQPu7Jll6CZxg9/NgF8jb
         A19ojr+vP7z90Cnxvw7lPRJ7vqD+kTFuyjgheGPQaIjJvp1+6pBLEhzCPPUoolQtsUau
         euAsg0nZatiQ7Km1AiiMeCYCYucL0h15+5ab8wP4xpTZN8d037G9XWIH265LsLl7yxHy
         PxU0qEJNCzcWrQBJ1kt1kuUno2jGyqgjiuXBF7okGAiIOVM6+r5028frtE0Dg1r0T+Ci
         6c0w==
X-Forwarded-Encrypted: i=1; AJvYcCXJWtkZC7c9uZXJ35fH9Cn0iMCFu6MnTUB5kMW9/2ADwJfwOEfZ2EHTf7yOLajL0NkDTViC+0vJHNR0xhw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxNCGXB3ZvRyGIx4XV1nLHK05qpxjzFz58hZOTw3gHxnr7Q8yF+
	+0xmKMxwYQRYZG4WFcj4Itny7h66NFeXUhooAZQ6FbZoYQ3uxzuQhZZDHj5N/w==
X-Gm-Gg: ASbGncttgn0bLHhbkAsC6XsB2d3xBJ2/r8In2z4u5rP5hAO3I8KSfkh+azjkodKXaYM
	k7uW3kiCLyGyzfkBfAcwUK+rNMLnbMSl2jYvv19zenvHN5KGsPXUDt+hTjCoMidg1bbSRx03tgS
	VH8L5jsPWHYHUQ+LTlUmfsYWrtRFDj0CyhNE5HPKqDo1qQnvxAh1tqAi1xIjlMCWFH3DU8Lv7II
	+BwZo5G+sMwgQrHTEy19jd2EOHtk6Ny6NOq7dYD+vagjoUoEiLWzDbbE5uBQuW+i9AUGX9hL2BW
	rhOjILsF6huIS4zcHLlovbFqGwK+n1+4asUBUs5mlBYu0WUqfp+z6kPWDnB6rbwHH8Lx7nHgZgf
	zYB0NvuEKEpkfTeTGpDXC5aHQuFTU2dP8JDEO1JdNtpI2eMNLiXFSlNrHm7re9XM5QOl6QfVUTI
	8Px5bS8DSgValX02lIEq3r/N7v59vnphQ18rIb9QydOFBMGuy6I948fmZrCXkvJGy0vwbN9WkPP
	7aB1g==
X-Google-Smtp-Source: AGHT+IHllvq11IvDLajj8xHW5uT3UeRGLK1mFDGxqYTfZLrLjLfh/epSzbZCpYMmk4Nyq0zjxJyr+g==
X-Received: by 2002:a17:90b:3c44:b0:32b:6223:262 with SMTP id 98e67ed59e1d1-32bbcb945aemr14341441a91.3.1757318545276;
        Mon, 08 Sep 2025 01:02:25 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7727bce1b58sm15186600b3a.9.2025.09.08.01.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:02:24 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Revise Meta Santabarbara devicetree
Date: Mon,  8 Sep 2025 16:02:11 +0800
Message-ID: <20250908080220.698158-1-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
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

Summary:
Revise linux device tree entry related to Meta (Facebook) Santabarbara.

Change log
v2 -> v3:
  - remove mctp node label
v1 -> v2:
  - add 'bmc_ready_noled' LED and update commit message
  - add sgpio line name for leak detection
v1:
  - add sensor nodes for extension board
  - add mctp node for NIC
  - adjust LED configuration

Fred Chen (4):
  ARM: dts: aspeed: santabarbara: add sensor support for extension
    boards
  ARM: dts: aspeed: santabarbara: Enable MCTP for frontend NIC
  ARM: dts: aspeed: santabarbara: Adjust LED configuration
  ARM: dts: aspeed: santabarbara: add sgpio line name for leak detection

 .../aspeed-bmc-facebook-santabarbara.dts      | 856 +++++++++++++++++-
 1 file changed, 852 insertions(+), 4 deletions(-)

-- 
2.49.0


