Return-Path: <linux-aspeed+bounces-2056-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C048CCA0EED
	for <linux-aspeed@archiver.kernel.org>; Thu, 28 Aug 2025 07:50:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cCD8G2cYMz3bqP;
	Thu, 28 Aug 2025 17:50:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756367406;
	cv=none; b=hiLFiMmvG4u75eThHM9w7EOWl/IrrMhTmsMaqW+DXdbEUX0JKCRhUSNb5cF1DNefyi4TRw9b4oVPtQT/6MN+EyQGsw8JQfquXSMx9iQ1SnIMfSNuqbr+4saVwjmbLXeF493miWLlAZMpMvHrHnl4NQUn/7l/Z28bznDSuqAoFSOhwUIPx6YCYUs3RzL31aJfkJIew0UhTWTZJpzAJ03gQ34ck3KdHqj807y0p+6PEQ0jMNqAdmZXsnDNCpSqAqHokANI4Ig/kYwmEBv61WZs2DEzX2edMcrhqft0sgV16TDoNifQqhZGBsAflSO3RhCkDnp8uoMKXlbyZ+7FkaCauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756367406; c=relaxed/relaxed;
	bh=NjHOGNG4+d7HZdoD4W/KYIfSNIi2J/bMo0iyGxOFrQg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=H3ZmRxZISjvxcjsyLlgEqdDnAKM0twcFA3Cqoi2YYWgiBycIid7oFVGs2OhHKzvdC31zbeILDutT/3BlirdM4onhEl8Xv9DwtTQN6lbx/ct6AA5eKNSTVvvb6zGMsPaeeU4Z633qJo8rYE4yeMQb4n44JesoEtvVz8TTMh1w8ERXZp+FBMofWr8R7gx71gAZwgwdK8LYf/egFu3b9NJw695CrkSjVFIjNtzy8JQOy3zQJHMfGDWLmvzmGkB4ishdeJwHNMYSUhOYer+hEQ7XER9wpKcXgRQoRxZbukHxmjT8v5ABvmEuCgsYmiH+tYWdOhtmoHAEVKTRMVXz4tMiaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=geTAoQvW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=geTAoQvW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cCD8D6HRbz3069
	for <linux-aspeed@lists.ozlabs.org>; Thu, 28 Aug 2025 17:50:03 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-7704799d798so537815b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 28 Aug 2025 00:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756367401; x=1756972201; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NjHOGNG4+d7HZdoD4W/KYIfSNIi2J/bMo0iyGxOFrQg=;
        b=geTAoQvWThgzvWBMIgCYS9wiPo4QZFwK5bDRYgJpfwN0bA6E8bgDr0Sw1NY6zTLqzV
         s0TU/8+n7r3Jkif6yw8W2+j5pHTk4sJfqnBORqVR1XPgTOw9frW8ZaZBPmxJm2l/yHN6
         3BOw6SlaxpEuJ1IXUvAcj8//SG8YF+TfdRkLBkrTXbLQ91YibPRID288B/7wiSHrxJi1
         KEy76Ce+RQxhAxAJ9sJtVJKp1nw7lZX/Zlxc4FUxSuNe/2QPki5VEFBUhD2fwYEoh6x7
         f6JkeFfP8z9T5kiJfKWmvxoFbbBqrhRpXqUxZZ8yUVOZC4PyILJ4QXf8lTuaqS70zyLC
         P7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756367401; x=1756972201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NjHOGNG4+d7HZdoD4W/KYIfSNIi2J/bMo0iyGxOFrQg=;
        b=mG3PpwpI+TVtx9qU8Y/bp7cWfwV/2xS6Lzg5+M4cpNqB3JNx//RElZ1zRxbGocIigq
         b7PlruZ22xLeWRcGzTPGynA+gOfeUil7t7GRm+MrPOovR+k6l4Odb8DMorpBCukFFZH+
         hhFIoXBmWcbwoXtcjOLadneHGhHux11P1YMKAG9KkG6+VErwRq5H3XsdiZ5HlGg+tB9L
         T42udhNqB9OpoBiCXFP1iuXmioikWvdBevaWzK/qPo2v9e+dwKNdvD+GZn/Xam96szXn
         7HOJ7Ol4L9LhKvpFoSmNeCblodiWgt4yRwMM2Fd+ba0PVHRIBXn8UZcYeKHDxRC6x2bO
         sDVg==
X-Forwarded-Encrypted: i=1; AJvYcCU32x+uTIgPshePMxVoHEGdlvku7NH5wyz9DANPp/flTIN0Qy4xqbXO8TfnprPDlouNKPXuSXJ7EFs8RrA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz2fbe07z9euQGNyQ/7YExohAdkPmPU03uyoja6uC+GPAqWKiBw
	aVpEbX1wb1urReO4WXaXo3yRoD5whMgECzLtvj1PNXkCxe1RM+tID8lp
X-Gm-Gg: ASbGncseV6YsYSeX1ax51r4xh6EGcNog1jT6lBEYMSSkGF1SgBpdmJ2owRN6vb5MXHZ
	fBI5j+7CVXe7Uv9sO+3aHGvd8bbDKfknzcMKi5+Fz94wkxZnep5Yx+MRxOnUBtZ3HZncCn8oFUk
	KKHwgNcVnIoT8PD6j0MDsYyK6yO2/xBpYdhj+EwGfiX/dfvUujJ6K2ztQoyRiw2HvG7YQxX/+zT
	9mv57bfsEDdhzcsG3rVN3Wbl9MilafLrfiTNHohK2De1riLqMEm8Q51NTcJvmtifxEJmM7S2AFR
	GWpgmMl8PohMQjlrdMTjnYEskv3vYs2OK4zLpNCFxThMVr2MsfCSnCtg7weB+sXxxrNGh/0aiQN
	H3iVwm3li8ReJa3kbVl2nmMwkL5GMwckQLlEW7VbU02Dok8DmIu0V6RJXblPi2QkRZEZ3hlwvhx
	LtrGHpa6jeZGEqgfpEd1n3uXx6enBY/4Ji/L2Vm2k=
X-Google-Smtp-Source: AGHT+IH5WPqqBozEMKrHMq/PF8PPjFfc9CCGsxQOZ5GAqhbwcMu0aIAwPYCwwEm/tWUHMLGYhvRR/g==
X-Received: by 2002:a05:6a20:8093:b0:243:a0c3:49ea with SMTP id adf61e73a8af0-243a0c34c2amr6067769637.36.1756367400761;
        Thu, 28 Aug 2025 00:50:00 -0700 (PDT)
Received: from peter-bmc.. (2001-b400-e35e-4238-7ad6-5c9d-99c8-92d0.emome-ip6.hinet.net. [2001:b400:e35e:4238:7ad6:5c9d:99c8:92d0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb9d226sm13272038a12.41.2025.08.28.00.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:50:00 -0700 (PDT)
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
Subject: [PATCH v3 0/3] Revise Meta(Facebook) Harma BMC(AST2600)
Date: Thu, 28 Aug 2025 15:49:50 +0800
Message-ID: <20250828074955.542711-1-peteryin.openbmc@gmail.com>
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

Summary:
Revise linux device tree entry related to Meta(Facebook) Harma
specific devices connected to BMC(AST2600) SoC.

v2 -> v3
  - Patch 0003 - add HSC mp5990

v1 -> v2
  - Patch 0002 - add power-12v-memory-good

v1
  - Patch 0001 - add power monitor support
  - Patch 0002 - revise gpio name

Base: tags/v6.17-rc3-39-g07d9df80082b

Peter Yin (3):
  ARM: dts: aspeed: harma: add power monitor support
  ARM: dts: aspeed: harma: revise gpio name
  ARM: dts: aspeed: harma: add mp5990

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 31 +++++++++++++------
 1 file changed, 22 insertions(+), 9 deletions(-)

-- 
2.43.0


