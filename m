Return-Path: <linux-aspeed+bounces-2033-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9D0CA0EEB
	for <linux-aspeed@archiver.kernel.org>; Fri, 22 Aug 2025 06:15:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7VKM6BXwz3cR1;
	Fri, 22 Aug 2025 16:15:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755843303;
	cv=none; b=orJicqWM+qAar9wrvYe2LQm/0GpOkwpY2gODa5Kyx4w/H/rIwPQHvN9g5FRGDVhzzIgmth/iJ1ZiuNJgVMgY+5DyCyAgEQ2dZZhSjL2U57R7mhsxSuxdun4LeWkgi+bgcHnXHrH7SQmitFHHupuanNsR0FMMbbj0mwe1GbKIu0MD8/yDypbQcpXx7Sxv7l0ryv5WhcYPib1pIA7/yLK697vpt6+GDf/wrVKJlNwvwTWodH5YMSvrwghihoprulXANT40r6R5Flb34qEsRDtORm71a+S8K7WliUoNqXNEOZstNa30coXMuSvfdwnZqhOP5gIJ5mpi+YJW/P2kBPlvow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755843303; c=relaxed/relaxed;
	bh=ReUPEZ+L9U/syQfiF/4viioOEqFIy3ugIcULtGFh8A4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Sx8k6v08PLJKJkfMhbz3CsjA9V6EOfb9PxETqo7CHQqxVb+FigKusuWi+ay4Ov1RHukNqN+03etQ3iP9t3jN6XHpGCGqBUI1PacZX2Nz5CtRsxPO5eVtF9wRBWXpDZeHxpCoSLjEfKmo84iG5tDnl1cfwpOczMjNEIIFXcL+uy26yqNFBwx/r+udRhDaF8sAVd0FEwIY0DRYw0/GYVDf2A57B2/9T/ZHcShDwThK+n9GMdSK9gfoLU7jdWkwPXN3bezHrnJ7sJ2o/zvyvqbJecxrldmsSwdlQo/9hyijTfTAxxy8HFWOonSgfz0Bvv8AHGtvT/INmjqEESythAth7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KRYi1r+d; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KRYi1r+d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c7VKL2DDHz30MY
	for <linux-aspeed@lists.ozlabs.org>; Fri, 22 Aug 2025 16:15:01 +1000 (AEST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-b4717543ed9so1144514a12.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 21 Aug 2025 23:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755843299; x=1756448099; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ReUPEZ+L9U/syQfiF/4viioOEqFIy3ugIcULtGFh8A4=;
        b=KRYi1r+d3RhSUWvnsB6L4cV/K2bbqoolskxda+WH/gEPt/LuKfc3F38+DXxsSaNPpr
         HkZjS4qsB3ZJKFtvfZm13vuVUFG7Ykf2IfE8xg8roNJcjkynfDFzgGolw2x8vwbXrOqF
         gS5UP/Aj4baHP1/FA+x0/f5jXp2/qLnWS4dDP1RYMRTarOr0twusWoAE6FJb2waqd+ed
         vfn/JGMqpWtul8cz5rXVeLTGAamZ6fwj5YKvD3xyX9n71BY6wCc5ngHqfNPLgNBV4PW0
         d43ghNNCotQmLWkEPE3uuCooFpVbPjOiVo0bz4z61XdI3Otz6/1mpRiLJyg2U52e7kVj
         4Uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755843299; x=1756448099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ReUPEZ+L9U/syQfiF/4viioOEqFIy3ugIcULtGFh8A4=;
        b=dvmwf2LHlUbqRPgtvXsUYgWZggQPkoonqGljdLywmBTYW7LIhukAbuvww8TqdIeHrN
         5YEUbsOcPgRnuktkI4HzoZ/VR4N/1sxI6GIqtQsbLXCYruA5TgwqVXBigUluc4X1CnNv
         1oTqaujhJNyDIHfjfkTxwQ4G3EGbfOi+icUvf1g8f7zC+eXQ3IntXLbQ9JyHihn3ijBR
         uYpdQWs6pCRQR8utHmj4CJ49FnPDiiCAggCya1BTj0/hf562DXaq9CSABaYYRlz/px4H
         WzWdJFsWM+iWNLu+nZQwl49/sPtKmek69kGedacmFv7eLwOESbYrfosOQDfbn88DY2K8
         YXcw==
X-Forwarded-Encrypted: i=1; AJvYcCWNuAjdkS/rTyTBmiVyJl5g1T+2qBrfA6ME23bejxmx8i3QtISLZ/FbX7isjc0as5azv01NFauEAyOXue0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw5SBqH30m0SpZ/w/Wc0yAc5XszNfFqEy0CmOgiSsSAHxqghDna
	95Jh9pFn3jdtodFcll08QgHvZK+Mh5cD+5a6qINJi6D7bo7kLhCxaORj
X-Gm-Gg: ASbGncuNWSl5BjgM5BKZQDFjDQohagFhE/pARRSvzwHhLG4mVgMDYLviXxDkB7cUHPz
	71ZSt9GwXvjjzqPwdH41gVmfeYyzo7kQbAFZtHvsNBWz45faS21XOpUq+0ri0m5dsaRS1ar+TTz
	WY8xH27f8s+hKbJCw0m3w833Mb63bVIb9AUB5deHfkqfCsvcjyls5Wc9Rpf1fNZyjkcc/XNER/V
	sFYjEJ2HGvyGh+w+CB8rx4CEXG5JydvabK0jqC6InUKiZkQ2XXpcuXxl2OmiCm8n+QxIBPz12wP
	o1/bfG6DbfnCfGXy0fPuCtYYYPy9hVgXJ1yEROkDX3X7nFYY1iL7YrWnOtEqkTXSij4mipAI7C3
	/C1FkZFGBZRELgf3H5zGRwBhm1Q5Dd/KY46ChN/8qagpM0VVSEBFEIcTr/Zp6ABwzqsyTjD+/k3
	JG8S/7+AGtNmpW4jVLfzIOtPWlvuUMa9/yg7Y1cO8=
X-Google-Smtp-Source: AGHT+IGW9JepiPFOrIKaV6tWBj8wosVylxBRGM7Di3FDW6E6ZDqNYgeHyHaeigxyiBCNZz3dVEHg2w==
X-Received: by 2002:a17:902:e888:b0:234:8eeb:d834 with SMTP id d9443c01a7336-2462ee2bc9cmr28317435ad.16.1755843298776;
        Thu, 21 Aug 2025 23:14:58 -0700 (PDT)
Received: from peter-bmc.. (2001-b400-e35d-8041-a0f2-62d1-f7aa-e5b7.emome-ip6.hinet.net. [2001:b400:e35d:8041:a0f2:62d1:f7aa:e5b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246181c48c1sm28660385ad.116.2025.08.21.23.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 23:14:58 -0700 (PDT)
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
Subject: [PATCH v2 0/2] Revise Meta(Facebook) Harma BMC(AST2600)
Date: Fri, 22 Aug 2025 14:14:50 +0800
Message-ID: <20250822061454.2610386-1-peteryin.openbmc@gmail.com>
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

commit-id: 2236141ed3d6f31f53147c26208dafef6051ae43

v1 -> v2
  - Patch 0002 - add power-12v-memory-good

v1
  - Patch 0001 - add power monitor support
  - Patch 0002 - revise gpio name

Peter Yin (2):
  ARM: dts: aspeed: harma: add power monitor support
  ARM: dts: aspeed: harma: revise gpio name

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 27 ++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

-- 
2.43.0


