Return-Path: <linux-aspeed+bounces-3960-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C152FF8860
	for <linux-aspeed@archiver.kernel.org>; Sat, 25 Apr 2026 06:22:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2frl0Rh3z2ynZ;
	Sat, 25 Apr 2026 16:22:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777023033;
	cv=none; b=KHtoyA+DyPFoX4tsWVXkH1AJNHeW/sFs+EqXBbkfL9v9JOJr6rICbgvETLuvBfh93rtuH0jl6a9K9N3IhWR02GCLS/qCTwz1zf2u4atQijvLXniXcR2dFTrQdJPvRpMBkEqflOO9GjBb3IAyM5a8sSrFlNY6XVjZqpiSo7GETCyP8bhB3Nb7Psl5JGDTNJr9wsiwX9bhtScWh1GI10SFIpB6Ov43W8aDbkMTZ7VXtorjLkH0x1y/Urawz/1AiArJPyq0ONfigJCkVhUgMsrBIusGy/IgUy63ZrVv32S3H+/Bo5jOE3pmFeLA3Ig1/l/QUB5xzRAWH1exdBBjbj/2qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777023033; c=relaxed/relaxed;
	bh=ctvKOED8Rs2Y8iHtAz2kdUCrMqrD3cqKZ8ykp6Je8z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nrENO3JmTgFBADUjECC5uV4EZgOlcohREl/n6m+RVQppUo2QTeln9BO47V6PeXlPi7vpXxmeCiBvMTIUsmNFCwENjC1Pe4quNEcWEr44sC8ncO7mQkWOpKtOgXaqaGDyrauhLY9N4Ys+6oxbpLy7gk0nn7p2dsuhP61hF9jO/OAJf8ZTAfriQ72EXZNEO5Oxfi/crPbiOY+e8NKq/IHEEwYdp5SgXx+DF/nLHMd12Z6Ju5j3VHjkgdDic3fQon1uHOis6DGHPo5Hm0kjPjCdhJ0kSJGNTwYzIzxgIPpRvtBEt0YIm5zYYGcB6t/L2LkVBTge9ZM7+4XZS1n7SaltPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JJv8RS3h; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JJv8RS3h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g273k6CXgz2xZK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 24 Apr 2026 19:30:26 +1000 (AEST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-82f4a53ae20so5600775b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 24 Apr 2026 02:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777023024; x=1777627824; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctvKOED8Rs2Y8iHtAz2kdUCrMqrD3cqKZ8ykp6Je8z4=;
        b=JJv8RS3htoGdN2kVZguaTzY+5Gj0jEv2i5Yl+cNlUG+8tmpiho/4lq/E1EP0Swhspz
         tEHY9RUZJcinNYaB1tDTaCJNPU1pSDMdGwMYusgY3z7r1IB7jcmsLHnbKPCbEpCNmE6x
         tYW1oZbyyll+yXPFuUyBevc3f9lkU5fCB7bOEXaAHVlE5727PeigFSHEpHHmGHeFfRH5
         m3+NISVzUy23g5Gcuf8qKx/jCi5M9kqZkpM0YOVwtJibZ4AbIzG5ZokZna3hoHVSXUdO
         DitL2SZU6VMKS4E+NfTwWXaYZjDwPOxdvf/3Nx6WgVz6a13y22PCEiwNMCyMZc2idRaC
         CSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777023024; x=1777627824;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ctvKOED8Rs2Y8iHtAz2kdUCrMqrD3cqKZ8ykp6Je8z4=;
        b=atAkoge/eMJCIX+zCvxI2g0gYEDTS2K4CA9eK6yp/cBk1mn4nbkGnnJfMnhmDAvbCU
         77lQEZNhuWz0SkU7yJZoJn3ITZ6PrtzqO3+irlSTHk89u/T9VwVDxBvw4BxML33Jp+5D
         xM1nVRXhbI/22rOA2sPWn47QaLrbHiwwgkgxJUuJnG1TQN2Vclyou7t1OrvOqMWzbAg6
         OrsAZlXjHDLc+kjtWH1z649aR/UEvkvEhnc6GEazvdRohR2Uk48V3Sn/mM83YrXLziEw
         5JA8bUidGJ4ncMlrGzODw2qng57fZq2IMWmt7L9xEUeqydbNgDTLu4ahHfZkwul2A3lX
         pSZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8NMUJYK2Lp4zb6Dqp9SsGN+YSl7JtS+Cjka3mTX4sivegtCx7/Y+W7f7AkP7fm9fYIhWPlxNRN+I57tvA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxTyNcjRHuHZi1NJfRbm4SHqbFvfwLROyoXJHXs0f/h+eb1Ewth
	sqB8aY0pq6TgoCKkO+is9OL2hgjklGWCT7FQLQRYNVX6NLfcRuoLk0+/
X-Gm-Gg: AeBDiesqLh9u3l2YOyJPm6ae3nrz+2EPuVA0zQz0l4sYl15BgmfVO1t4tzT8NyIX9iA
	DCmIV/Dgqhte0QUTdKhidlGoOwxyngEDVrQ4TKTueRUv6qH+lzjrHj2Fe7LV+hdvTjOKpDHa7Kz
	aPC41gKUoXE/7Hq0DM1ZcBhRVh7O+9NjXPdMOI8TqUJVaS+xJ8MSkiE/+BUA8ZFfDFJpgB/XjJS
	nRwSkPUtmAZNYZv28xdjZAjn9bKYKPDjTOx6SwOjhDV9oy5xPkVBVv7NbvZhFSFzhWbXBo/0rFx
	MHjLLmyThayo2RYyWAg8ueabwfQKzBc2HQfrSDCVE3uXGoLwnCBUrbFCi96XBwO1sbNuiKdSXnE
	l57xaFrqpNWX+gIzuPQaSRlvhlLD/x4myCs3mkBxrO8W1vc80SOSfYY12ID+DOoPc++7CWJVRtc
	WLUMDkMLse56uul6YM1Kf52m64UiHmlvDIxqKTO20qj9rstdhoKGTipbqRgJ7+UxviFcd67NEKs
	A==
X-Received: by 2002:a05:6a00:bd0a:b0:82c:9897:70e6 with SMTP id d2e1a72fcca58-82f8c8e8aaemr33764558b3a.34.1777023024496;
        Fri, 24 Apr 2026 02:30:24 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebe92desm22658143b3a.44.2026.04.24.02.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 02:30:23 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Fri, 24 Apr 2026 17:30:49 +0800
Subject: [PATCH v4 1/2] dt-bindings: arm: aspeed: add Meta ventura2 board
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
Message-Id: <20260424-ventura2_initial_dts-v4-1-806b00ea4314@gmail.com>
References: <20260424-ventura2_initial_dts-v4-0-806b00ea4314@gmail.com>
In-Reply-To: <20260424-ventura2_initial_dts-v4-0-806b00ea4314@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=909;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=J3z5h5jN99f1BFk7jnvt5xoq1tLRgjc3X0kRzaksvsA=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBp6zhNERSg2LprjO3NpjL3691xSDiTsEpNmAsRa
 TWu4uACS/mJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaes4TQAKCRClg0K3CVbE
 gWQVCADEDV9vxWqxPFTp5UP8ETlwdmjYzpbjb25VL0GNAo2M6d2NcYQC+lIzeq2H2LQKFZ+vIEs
 8x0Js9eAEZtEJJJMfvMTw3ldf2V+onaTXiPfRa9iWvLzlxBPrkx+iVWxAMTgCWbBO5anuB+dzVX
 MARyd9Z9XKfpPM2rrPS4Pdwx9Kc+H7JjP3cwz2G5HOF/YgbYeHbs3cK5eW4NXOhqkOANzngkFba
 jDbQPESXJdHGs8wr5kmiKBQnzHB0IFH/5Nn0ro5a2uQXhUVRzEzbT2uCPlKoR2ODZOWt9KNgNre
 chIhC2L3as5AhSRsoM0b8Hl4j6vutFSgjouOmrD9MV0/5cmq
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Document the new compatibles used on Facebook ventura2.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 9298c1a75dd1..d48607c86e8e 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -92,6 +92,7 @@ properties:
               - facebook,harma-bmc
               - facebook,minerva-cmc
               - facebook,santabarbara-bmc
+              - facebook,ventura2-rmc
               - facebook,yosemite4-bmc
               - facebook,yosemite5-bmc
               - ibm,balcones-bmc

-- 
2.34.1


