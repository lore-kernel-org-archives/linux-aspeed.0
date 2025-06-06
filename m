Return-Path: <linux-aspeed+bounces-1325-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA282C5AD49
	for <linux-aspeed@archiver.kernel.org>; Sat,  7 Jun 2025 02:06:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bDhPF1Jjfz306l;
	Sat,  7 Jun 2025 12:06:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749205692;
	cv=none; b=AbJPoqh9Roc6K0raGK7yC5NO97cxTBi7gfLc6inJUvvtEq44vLrPtXIJ5EREb/sCs9x7PVELqn8YK3LU++r083rP3xkVDQTG1+jkFX1dkOYStPl8UEpA2Fx4sRw/OXJFg9CUflm1oURWyU0vGlZhSiuuwNaYHc/5gwwq4sDDKgLQ205j+9Azw7fkT1E08KT/Sn+0chYKiAVu/GxICWhxwQ352uRdwDnIVbMUI1cqu78xqjjc7eY8KeDmTcbJXTJWv3v6ITYExI4wCdfU2Mn/EgG2HOzBQ9pmm6sTRqhEFOgfOirSJdrJP2qhrkneAUGlqazpw3RUYVF9mtInJ11k+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749205692; c=relaxed/relaxed;
	bh=Kq75SIqPsOJ1DQd3x8jl/mu37HxVt1wTwstMgXOJ46M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZJVZF2bM86LdxZD7r+dLe92U6efM5Xus+D3e+05l9ts3zAzas7G8vCewxHfm/DBqeQTKwFHw7oqomwQc7bBNow6AVslwgprkrHiSTdNJ5lulHf9K1sKI+A5GTSsBOOaqj9qfFw49vFc8H7/cMiqE7cn8N0uGxi/rUZmXDBGPy7Im4cR2L/yPEoLATV/5FXpaTqdhhU6YhAMI0iLBjWmd9vJrkVpcFIihAUg4HjBfmN1qHyDzQG4MXvG3dSVV93wpvSIxdd4F5qtjLrR67YeLDgfGOn9G8Q5mbUSVWic/0GF41HDKxhCbFiKlov+W6TclOjfLLWiUiVBTZDzS2k/0Ag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=a7jqjVyb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=a7jqjVyb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bDHZz2nhpz2yZZ
	for <linux-aspeed@lists.ozlabs.org>; Fri,  6 Jun 2025 20:28:10 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2345c60507bso13988745ad.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Jun 2025 03:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749205687; x=1749810487; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kq75SIqPsOJ1DQd3x8jl/mu37HxVt1wTwstMgXOJ46M=;
        b=a7jqjVybNFnhtZ/Ti3j2RtbWIgyOlQxtkL5jN9pLZET3rP6sFUHnkwFjPRr3YHvb2j
         ltxi+o+QlrKzBGdeOBmMqu/899baHKNJwxX04EiUthvoHUQssPSPy9tO0eVe/zPzM16f
         5gKPA+2jiLpwN/ONNI05RCOiYE0I5kEOwRvYPHvgO7GXuf3Yz4t7n2fcs4X7IIuiKJSR
         umui3MX5hzpyBU3CHAzb8VGr5Fylbdfe83TYi3ZWmn3gbDP58AZPqTJs1J+LVqU+Qe3z
         +nGrdHiRiZzcITEOTwxIfJrKv0GAqdhb4nFfUUFf9qjsz9230rbit4nUcEjJC3TMCeG1
         UQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749205687; x=1749810487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kq75SIqPsOJ1DQd3x8jl/mu37HxVt1wTwstMgXOJ46M=;
        b=N9u7zJbzETJEMlFqII9VrRL6cUwVjbQ85uyMD2UgM8ufJQkCgH1b9WQyem+ZOrwJGU
         3VYSx5gl6vB40E+Yui5Mp210fZLzKWHmdeMfiWlYwDWTSsBBHQczNTyjC02wB/c9sWya
         p5e+HOh+tkGFvk8dvV4o0r2+viD5IASelLVUhQk1s7scz3wTMiL4Q2DoNwpPBWxDk+PB
         TbZ8FjQYK8WChLTxbbV40PLy4XRHc8ckt3WzP/B7WU1pv6A85UZSaIdXHKTNTJRf7/10
         X7BaAbDJKF9ZWS7RwXClSFCgTvuYz232qnLKNqt51VNcyg3wlPL7UP7JejMtsh8Hmyrx
         iWnw==
X-Forwarded-Encrypted: i=1; AJvYcCVlq4j+D1RjZqScmP2IA/AVWOeydweZBhAWMXt87A9v9UDRe8HAFryOzEZv+SaP4tlhJ/JCW+IIBlMP0d0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxqvgTEskDSSd1LPBdfCQ9TAlUDLI/6VhptzHk6PTEAKcGKTA4d
	HLDrADYKsc+7qXIJ50ESDLpn6c6uwALhPYpTAc/HGt3gi326myUiNTAXGBlliTCfdwY=
X-Gm-Gg: ASbGncsuK7Nx3ti7FGBjJsfJt4zle7xR+FMmIiUCeBlNLLAo7OzV4zBwtA35DPf+tF3
	YvDa2XQ3RAEVv7PG2nE21BezSJwBh7FN4sM4pPPyjYdir8cgDbhJq4DJ/tQlkTzYlPyloOKjnzK
	gfP+tFxqV6wppPdUn8g5peQosvOhTJi4e3dR+Zo0AshfkLwxO7gzGz2kDfmhGzRwzPLiU0Pb1+X
	8m2Vq11RRNdB0hciZyXs8LrncgcBD5v2BRLym9kR8ZbpWUqE6mxn3Vkvyb2tu6RD4RL0/ctlMVC
	Ek9uVw0Pv2jnTyoDqrHl586ismn1g/9B1OWLc7pQplkIvw19vrcaVodsmtG4v12PXKL7ujOJjuI
	TidFWE7FiVqcU1kgt0Ok7cT24VUWW+V6qKfVINhmGyV33l/OfRPu7Dj8h0tPMVeyklt6/iWcE7l
	Y=
X-Google-Smtp-Source: AGHT+IHWIRzmPF9hBfCr89nWxfu/OXV/L7N6WZrJscNojX76/huWUu2nhvxP0kFj4o42XVFggGnTGQ==
X-Received: by 2002:a17:902:f652:b0:235:779:edfd with SMTP id d9443c01a7336-23601d97820mr40085765ad.39.1749205687155;
        Fri, 06 Jun 2025 03:28:07 -0700 (PDT)
Received: from fred-System-Product-Name.. (2001-b400-e35c-06eb-80f3-97a6-ae1b-00f8.emome-ip6.hinet.net. [2001:b400:e35c:6eb:80f3:97a6:ae1b:f8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2360307813bsm9632885ad.22.2025.06.06.03.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 03:28:06 -0700 (PDT)
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
Subject: [PATCH v1 0/2] Add Meta(Facebook) Santabarbara BMC(AST2600)
Date: Fri,  6 Jun 2025 18:27:52 +0800
Message-ID: <20250606102802.1821638-1-fredchen.openbmc@gmail.com>
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
Add linux device tree entry related to Meta(Facebook) Santabarbara
specific devices connected to BMC(AST2600) SoC.

Fred Chen (2):
  dt-bindings: arm: aspeed: add Meta Santabarbara board
  ARM: dts: aspeed: santabarbara: Add Meta Santabarbara BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed-bmc-facebook-santabarbara.dts      | 978 ++++++++++++++++++
 3 files changed, 980 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts

-- 
2.49.0


