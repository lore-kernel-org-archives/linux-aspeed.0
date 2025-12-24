Return-Path: <linux-aspeed+bounces-3213-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41D2E784BE
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Dec 2025 01:41:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dff8P46Ysz2yFb;
	Mon, 29 Dec 2025 12:41:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766558750;
	cv=none; b=Xj7ISsPj7D/3qikQJJ/ykmb7q8gVeDTam0ZRQecm3LeQxm7iZdOMmMBYOl8uTyCGYa7W8IrGPJuEn+/rCVhQsuQXGfdDoh6jH7w95MG+n2TZ3ZZWTmP9nS6FT8QMe8WIh3oI3e8XCFQKaV0PdT8ra2DJeT6hDiUz0fYsXbc5BYJgPeAmCuCbNw//BIwX8pleG3dw2e6vXwNPdBrCEpm07jPc0dhB/wmjwu2IXgKUV0LQbqFH0RxmtmvcBngFzlvdFoWJBOG3BnBowLuleEtVljpbtNZ4s9XDTCFxe/d4r7F/Zj3DuaPkMw3QV6A/ZWYOLYJ535Kv41n0PSLE62WuCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766558750; c=relaxed/relaxed;
	bh=rcXUuHqHsPLnPcdJtfcsoHeBwUrBqqzkRj7ul8huktQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YrfvG0nVq3cpRzZEwE2nbJwAGN6uUk2eURbgyuWbF1hNDszkDeHgZOm7SvSRtAbAHgHPwc5fJpfIDBjXJ2cYqBpMypX+asQ/Dog4C12NrL1HjKW1v7dH2/fNkcqNLtp5qC+zWhAk9WCFtRuiTTevk2Vv+TUfSQ7vNPF+Bc1EBryiHgcCU+YoneATFcICl0a8qzfQW7PR5thFznbZZXYbmcDU6Ab0dH4YBWDL0mge5Xvgx72cBKN1QTloiyJU4YW4IMmRDKEU9W6j+lXfFPZ8sXOLfla2Ion+ksg2TlvWzeVlTKsMzF/o54AgGI0WBIxEVYlV9GpSQ2158m4diRBo/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=as8ghDJa; dkim-atps=neutral; spf=pass (client-ip=209.85.210.169; helo=mail-pf1-f169.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=as8ghDJa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.210.169; helo=mail-pf1-f169.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbj7f12lZz2xnl
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 17:45:50 +1100 (AEDT)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso4774708b3a.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Dec 2025 22:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766558688; x=1767163488; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rcXUuHqHsPLnPcdJtfcsoHeBwUrBqqzkRj7ul8huktQ=;
        b=as8ghDJa5FuMuAeWjE7sMeR8mDlKNDLLWNpXPGmGpj/CVLQbhSZhXfixd5XbvRn3uh
         1k3Li6qE/KHGuU1I6yv2dfXEUX6NXlk1H0/E1k4aaN5kfHEhsDHxSXL4qAyd2PHkWut2
         /DlxRvlc+FVqPy8FgNVibvEw2tzNzcOqwWTrnncdbo1YO3ZAQEH4z5ARzYbbUFvh1ovU
         kzc8w/RgYG7+5YdaSZzWYDCeT4tV7dUhhtFOtvzLPFXlgSVapkc6OoDi0Zaq31I9lNm3
         HgxWF0pDqHQZ0Q389BCFHbIvM9UaObPHAAgQMu8AoyUfyweCJw7uQo57fjw6fAMH3yxQ
         sshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766558688; x=1767163488;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcXUuHqHsPLnPcdJtfcsoHeBwUrBqqzkRj7ul8huktQ=;
        b=jOKfuIkisjToTl72ODgrUXhEI/Y6PATSfGxlYo0P5H3iPrbL7JhTI+NKVxYqJ/V/uk
         pBtkcyklP0BHExQelo7ABvdag9rm0DfowsvXLf8MmXBhE+vUqE2mnWPQiOYIzjPnzQ9W
         RlrDBYEG6Hle+nC0zBPSSSapI6CrDS2JqxGJRXyGSWIPYRkgQroajIk+SFu6UW5l8jx1
         c7eSCLSBfzQb4FIazYaLw2tzjWErHIdQvJfn+GnsSfuH9t9+mrsX5SqGgVI4Dl8Pe7jJ
         SLupveFIxzgsGoddJ9zNT1KxOYwTHtg6RAwZ1QdcVGWuP12nUoKtL4gcKcOKLHy5RWgM
         IfyA==
X-Forwarded-Encrypted: i=1; AJvYcCW09tiNiIFXQLdm4aUXsFGZHu5mYHaZHnU9PBhrHbK5DFdp0oPHBWf7qRdZ0haRR44mxp0zwop5T9YAR2Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzvQHYA0jPwKgsFUfQ3HGH12PIsyhRSW4BsK033krDA3leQvzTa
	n/4FRqv97m1ESQPSz7GlIh3xGv0105nQPDNplsbxyK/rUwtDPO8MZQkP
X-Gm-Gg: AY/fxX6s8BIdKcgJGfl6IhlW7g5/ub+faUTzty76XeY362XX57OhPyQ3NC3QwOQkMUX
	ML72+E31/1Cm3gTp4cO/UC907OWxMO2fxr90WBg7ieayr6rHJByqanAcUlqdDKC0WxvQnys8QnN
	NJD6Ld93tH7GIHY7lI1HVBcahoK/zqswxaQMUVhk7T+nXmXXFnoNJFtaAuPUN2Ltz8E9vFrTLkF
	mkIAy2Ph6VZBlj/bOZ036uiawYxdqNvhaxSRqYGIIvNW98VknSKbRIQJwVt6sesNYMR/Apgku+8
	QJbpqsxZvRt29KETQafgRpXOb1J7ZDp/55w5NaPZEcFtv4W4BdSMVtD0eHd90ciquit/6nN0QmX
	iRHdCfiKMfcZTsqQKZQAkR+yK9vSqTBEETw6+IqAmg0IxwAYTh0qkFHwYdBuDDFsvNexEy9bZwY
	lRpNxU4SBW87LKFYbvcTtpuqfpl7h7o/MiRcDlfvm7jE/TI5orl7Y=
X-Google-Smtp-Source: AGHT+IFzM0YtWfrF80UVaawG2TS/l53Sn0EPeZUElG2pvPac2AyOx4/2qKIx+1lXLB+Crhek66ij9g==
X-Received: by 2002:a05:6a20:7d9e:b0:364:783:8c0f with SMTP id adf61e73a8af0-376a83d8902mr15918646637.33.1766558687573;
        Tue, 23 Dec 2025 22:44:47 -0800 (PST)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e7729b04dsm8320864a91.6.2025.12.23.22.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 22:44:47 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: [PATCH v2 0/2] Add Meta(Facebook) ventura2 BMC(AST2600)
Date: Wed, 24 Dec 2025 14:44:37 +0800
Message-Id: <20251224-ventura2_initial_dts-v2-0-f193ba5d4073@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIANaLS2kC/4WNQQ6DIBBFr2JmXRoYI9Sueo/GGIqokyg0QEkb4
 91LvUCX7yX//Q2iDWQjXKsNgs0UybsCeKrAzNpNltFQGJBjIxCRZevSK2jsyVEivfRDiqzl7aN
 GpQYpGyjTZ7AjvY/svSs8U0w+fI6XLH72TzALxpkYuRRSGnXR9W1aNS1n41fo9n3/AouFguG4A
 AAA
X-Change-ID: 20251222-ventura2_initial_dts-909b3277d665
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=879;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=azZjw8PVAWNPZynSiyTzQDrnhDzBZBhZaLDnEbGQPdQ=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBpS4vcWXtTW254mAtMa81OfMyOxzHujO8LGc3Cf
 aA9IBrNSMmJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaUuL3AAKCRClg0K3CVbE
 ga8jB/0fsX1Yn9czAf9jWr+dWRgMjd9p6K4v/4mIoZ5JgZA/ZU6vaeONX0vCj6yX9JekztiDk/p
 5NF+RV7z7JtqAJjgLhTTKYzkPprssM5VlvVz+UttrXPbG1rG0fDiI10eeFm0v2wWJJScAek92CF
 6GxiwS8ZAehRdFM5nYccny1p1xmmN7nlVS40qxO9Vc++MqeOGT/qr7aXefEoq35zDToi7385iTv
 TIUU/2r6vkAUhXZsFO9xB/cNpndZdx3URwituA094L9VFq4UNYIvE6mXN0By5tvez0E0M3gzCH4
 nIXJOQh0q1p0J5Z8WuW2YdRSNkTu0/QfPxDmOiCQj++ZMjAL
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Summary:
Add linux device tree entry related to Meta(Facebook) ventura2.
specific devices connected to BMC(AST2600) SoC.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
Changes in v2:
- Remove unused mdio
- Link to v1: https://lore.kernel.org/r/20251222-ventura2_initial_dts-v1-0-1f06166c78a3@gmail.com

---
Kyle Hsieh (2):
      dt-bindings: arm: aspeed: add Meta ventura2 board
      ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../dts/aspeed/aspeed-bmc-facebook-ventura2.dts    | 2945 ++++++++++++++++++++
 3 files changed, 2947 insertions(+)
---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20251222-ventura2_initial_dts-909b3277d665

Best regards,
-- 
Kyle Hsieh <kylehsieh1995@gmail.com>


