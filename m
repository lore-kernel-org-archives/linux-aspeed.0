Return-Path: <linux-aspeed+bounces-1503-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D383C7115A
	for <linux-aspeed@archiver.kernel.org>; Thu, 19 Jun 2025 00:06:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bN19L2Vm7z30Vl;
	Thu, 19 Jun 2025 10:06:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750239627;
	cv=none; b=UGIPRPLMZjDjv7JCAOuJ23IWS/6hWudZT1BBRP88zoUOTcEgmVPeVSsoHtZCWENW35aqbbu/iGuMHGiDkRtykkZQyeJxtlWaHkxEfzfXkeNdqBuMwCCZmg2QnAUb0AySpSv+4hpmdEEDLqb1faMssnHoXvr9RZN773nfTwCpWS64g4Tv0/qmhNQlFkyLQIGtdSefpS9FSNV5OR04MjjP1ri6VMzQSdu9SEBJInkZ04yORIH8z80pq4zg2Ig7qw4m+Er6HWI7rIXLt+Y1w0/RqLLarsNXIEvwzHhNr8AVWouzL+VFvgWtuO95j/uQp8NydlXqsQ3dulZJi+2/ndD2og==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750239627; c=relaxed/relaxed;
	bh=6V40YgN3JCSrvwEwSTqFhPuQ1J7Bi4GuX5wKRadAVp8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Xn74rRj/NwDaLk6c91UYh7CpDd4WAHlqHvIZcsWcLj7WNTImZLkfbX5bOlDI+61SP3pQkxO/04hMg5bWlngMuyxy1oMCmXigcrOsbT0ooI9myf3v8ejuEFXtm/uookEBP1+/mxSOrzIAjOzeZFI0fMU/v77fks6nXHM31cYqPw5/5Eb+QI5TMZ/H5SJf/K8peQSfflyG714MMRFImxdg0if6prRQvTGMCjwSCX+BhlJlnUB+duw1Qt1jr377mh3mFc8v97ZBt2I+T23GbIq3o95HjgAR+POxLcb32SyXK1NQ29OUXY/qr+b5MFvAMRZ2DyoFCp+QJtCmfOkMCUnOdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dZ2rQeRj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dZ2rQeRj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bMdyK6YpQz2xKN
	for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Jun 2025 19:40:25 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-748da522e79so912475b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Jun 2025 02:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750239622; x=1750844422; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6V40YgN3JCSrvwEwSTqFhPuQ1J7Bi4GuX5wKRadAVp8=;
        b=dZ2rQeRjiVGnMDIcVAoMjrMp0cho6u5LplLyFs2VzRB7AHrxKXQCgsCWTCLG7Qgdu8
         BXBMR36T/iHERIw9WZJsU4VF5UGkLdefSIPdZ64ri4+LdfhMf/eOM4Z/MbijssMmmvI8
         fJbqTXmYU8OOBScRMJjCglwgnxVk5KOoafGmKv8/a97VdrrjB1JJcvYx7e9Px1zG3Ie0
         jd+4IBaTgMKVv/LyG+bWez88LK6I6O0nhMK7wa19oBqVDHHyK2LNBgagIwoA9zdTu8BF
         7W7Wiwu91N5O2j2yMECH++auED9dR1zIxm/kZrSYrztQDBl4rqBBsT2kVA/IhnKfWEZN
         f6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750239622; x=1750844422;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6V40YgN3JCSrvwEwSTqFhPuQ1J7Bi4GuX5wKRadAVp8=;
        b=HNS+mnKi9wjkDcoPUjmmNx6CWfcPEsY3RnZHfbyDxQgvCfvoe4LI5AyiCt03E2X+jI
         5dixDJ7ywFGGY+xQEuPj73P49p3GcdZI+H5xG17haMCIczSEkkIEydp5GoD5Dvpw6SJq
         1xRv+0+TPMcp52w7Mvta2P4HyqujGwHp3aCifAI4i4LSM/U+TUBWQ8SXtuFtRoP2nEgB
         tyhtwHMr/hLXIZKc/lbviOQtVtxVhwHffvZHXB6ldsLTIkuMreRgdroAtPzCbItau+x1
         g1PQSepjK/sd94PE3OtLYH+RqVwYIujYFhF22QA+CTrZlIT/UzjfWOWLpUR0RbcXgtiu
         4m6g==
X-Forwarded-Encrypted: i=1; AJvYcCWDYQhtDgTioGknQWf/hCFIEPzjlSvYDSWVVKQZ2WhI2/5socPk5zLd5IYBz5OI0rWnpUg8+fDjI4i7G1E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwbiCAFKYcGO/iLDTmZo7OJiy1hJCq5+Df5CWbdLQLDCtImnLJb
	eBqeqTy08hJS+c+5TxHWFxqryo7DeUEaW/zNXpJeAaBzctaxvALJC/AC
X-Gm-Gg: ASbGnctwZ6ZTsoNnBu3QqVrRz2KZcxnhUaZP4hcvKaA8Thy4+JHdPTT46r9RkZ7sXAh
	sGbfIYGqx+lZ5FWTINt5Yt7+K7ooxpjwDUs1s3sxdb9rGzuucbAiYgOsn+o9xvkMtcFxm8dNgZc
	NZtliiDyyRI4xADY6yCVGREPvslOJ3HOiGUA0IKF40+Tq0Adck3Mi3S2/u5WXKzJyGOyVyqptPJ
	yKp7N8wJ5xHOhybGc56oy2KiGtjlDhYH4Qp1/OIerF7aJQfboSCYEH9ASLHYogUMWgn3EGJKTYa
	4hERppXMTtj++ZiDl2HFA9ZGs4e+aiDpBtrpeDIuGFkSWnKft0ePIL1TocM27z25dZUHFZqjYJG
	bOEyxCgSwPrjIbIvcA93rTFmWbyE6/Ug=
X-Google-Smtp-Source: AGHT+IFmAvBRfvLjEgPAy4QPPhzpRWWfiaUQs2yaKoSBQwrcGyeXathdmws3LB4L9psUMRmX0wfWdw==
X-Received: by 2002:a05:6a00:b95:b0:730:75b1:7219 with SMTP id d2e1a72fcca58-7489d006780mr23000088b3a.12.1750239622126;
        Wed, 18 Jun 2025 02:40:22 -0700 (PDT)
Received: from [172.17.0.2] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffee2aesm10527123b3a.24.2025.06.18.02.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 02:40:21 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Subject: [PATCH 0/2] ARM: dts: Add support for Meta Clemente BMC
Date: Wed, 18 Jun 2025 17:40:01 +0800
Message-Id: <20250618-add-support-for-meta-clemente-bmc-v1-0-e5ca669ee47b@fii-foxconn.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHGJUmgC/x3NTQqDMBBA4avIrB0wqYr2KtJFTMY60PwwSYsg3
 t3Q5bd574RMwpTh2Zwg9OPMMVSotgG7m/AmZFcNutNDN6oJjXOYvylFKbhFQU/FoP2Qp1AIV29
 x7pXpx3m1g35A7SShjY//Y3ld1w240TVkcwAAAA==
X-Change-ID: 20250618-add-support-for-meta-clemente-bmc-941a469bc523
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 bruce.jy.hung@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
 Leo Wang <leo.jt.wang@fii-foxconn.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750239618; l=815;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=OTnlEGQTaKca/djlqzs4ZnMpNa+lx1vDcpsU3Ydt1XU=;
 b=1KW8ySCD1lwOEWatymBInvgFZuKSAzEDiUjjNsKMpzBXo3w6/oThvGLzJ+lhEBQwV4vpQyNeG
 x+aTVtGRByCBMpJ7qfGgfxJFPMKDEVTnYCfzsgOMohBlUUAbl+ku1p+
X-Developer-Key: i=leo.jt.wang@fii-foxconn.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

This series adds initial support for the Meta Clemente BMC based on the ASPEED AST2600 SoC.

Patch 1 documents the compatible string.
Patch 2 adds the device tree for the board.

Signed-off-by: Leo Wang <leo.jt.wang@fii-foxconn.com>
---
Leo Wang (2):
      Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
      ARM: dts: aspeed: clemente: add Meta Clemente BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../dts/aspeed/aspeed-bmc-facebook-clemente.dts    | 1254 ++++++++++++++++++++
 3 files changed, 1256 insertions(+)
---
base-commit: 52da431bf03b5506203bca27fe14a97895c80faf
change-id: 20250618-add-support-for-meta-clemente-bmc-941a469bc523

Best regards,
-- 
Leo Wang <leo.jt.wang@fii-foxconn.com>


