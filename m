Return-Path: <linux-aspeed+bounces-4249-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21665CD98CE
	for <linux-aspeed@archiver.kernel.org>; Fri, 12 Jun 2026 07:46:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcBRK39P0z3bqh;
	Fri, 12 Jun 2026 17:46:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781249159;
	cv=none; b=mceDKPb3YLqegkt5IHVGkUP3sknvfuttZHTt59s123KYLoYKORurZKTYstLp8Tde6VgMaB6SaIbz/esSMotXxRZjyN8yrAQovOg9CjQQEaa0y0cxIZ/OmVxD/Mi/U23JoBwlfgx9sM0dEc6ufEmgxdIreuFi4CESNJ+LMV6siePkYqC2H3BHqu70zA0rtx4Af3DoPA3tSr7utj0LwWUhkzE8PStKAADROGSCJ3k23bjq2TC6hjtPKJSCQCO6LjA410ywmaV3DODwF75DTUi543e+XgWJ9n+MYxLC2BiRD/ITXu01dNq9p1hZ4jcPEygrlmqksKx13gwNq2HwpQqJtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781249159; c=relaxed/relaxed;
	bh=l7EX7vcwLIGLkhcOTF+L2EBQ6wXAup12KuoUfnu+n/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lLXdY3o9Wva2vq50pLyp3XZ9GEqqD9BKynM/bui9QFpXk/LcCvV4iaIDdJWa1ieGn4cjSMMUk6ilPSR1BhOV7gW/P8j3PauQa+bAjCA8jMhuKH5Sm6uXXITLFeqM4X9T0tO+zGPmcrNqTMsmrKtTvwRWjie2LbQs774kGKxrMcBfjnr30uq56pIKMhPdSyjlp9xx6bQofn9JrWUIqu237VRqznozI4n27IkXPD9+1vG5Bf8+ZPEX0BBLb1vRJ30V+bgykql+Sd3aOTU1YPZlgBl6Mmzg0uXVF1N8pMosbKstIM9gEe3LD+Bkhm1CU1W5fX4WBLn+I6vhpi4yxrZ08g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=bxyJfeqk; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=bxyJfeqk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc9zV1KVtz2yd7
	for <linux-aspeed@lists.ozlabs.org>; Fri, 12 Jun 2026 17:25:57 +1000 (AEST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-490b3e03939so5426305e9.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 12 Jun 2026 00:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1781249153; x=1781853953; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l7EX7vcwLIGLkhcOTF+L2EBQ6wXAup12KuoUfnu+n/g=;
        b=bxyJfeqkP6RwSmQbM5Kw+A8VtBa0MZwkGXPuivRQwm/7u32gOdP4wl7Fu7nd8tMDw3
         Hf7EB0LGvM7TQOs3Vzo5EAkyEr6oosITCH92WIY1JYD7BqF/KFdHD02hs6KuQHWhygOn
         Hw5XIQkuA4yoP2a6FPsuw1Cwd42DPoHNo2p43Db0dln6Qp7WolQO9E8IuZexmHqAKgQf
         UVqbskTKGHnD5WgyIyUKwTdKLWzI+TK9ZMtUZlt790u2DZCZ2CN/68UrAU7lKueSLtQ9
         sW4r+/t2jetlu8cJhQw8I19zlm0n68a/WttwgMObwo9Tm9YxCrR940FsYIaLlZISVFs1
         MQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249153; x=1781853953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7EX7vcwLIGLkhcOTF+L2EBQ6wXAup12KuoUfnu+n/g=;
        b=Wlde+ezZGMyIYfZn29vs0HLwTcn4o8uJaQIkPw184ML6grm8Z8zV22koGfLJb3EZiX
         1B2Ec1D1tlgA15ljeKrMSJsTixDxV7qvx5ZgVi7Dot+MUARp1gKu2vVfyLW+PttE0bFH
         PXBp9NePOXQFCH00T3AYHETxOC6pr7+D9Qdficf3kIUUTIljMZKrK+RvPvR3lG1+8mvf
         AbJ+9kFj1bDiRPO2An9ut8v3TZ7/wOmMGpJdE3ND1yz13fluMdD9nbI3bdbNEFhJ1zPX
         q/W8SoGyS4lN5/FbvY7YQZFMASAL+C/3Vq/748ZYTB8/VWElyL9udb+dY4xMVeT+GtYq
         ycug==
X-Forwarded-Encrypted: i=1; AFNElJ9J0BKC342HyHAZSc7A1dDvkdDcteLut77lCzihYU1OGY6hSuRzW+I0IKAqKXUAjk0a9TcXezWUn4hB6vM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz3K+A1UmyDYiVj61CLrGSQRRgQjKRYjON/CukajnI3NV6a5fzH
	GZMZxKNlNULxrB+vRgMCNhGP3cfNthmjcKPyIMvXrEU5c3YsXiyZ6J+YOO4SrhsRyZo=
X-Gm-Gg: Acq92OG+K1NVULCkFSvAwkqfer5YX7Q0TUjUIQD2gTVoX8TLKzlWj8z1+YzKxSFIBUd
	S1gL7Q9wV1jk6GlQzjhMe/y1VbSJs4AKx9movyHjSSiak7EY16i9vbCwXnkX2xW76urJeDNVyAq
	DUjEydDT+GAcDKVcZR74ccif1p176deQysIN7IeVqS4QQDZDa4GUBrEApYYOI6NSOBpITJLjWA+
	hfoXLngCSONPNhxn6me1l+ztTfz7WVEcbaoIPTF2j8r9KsgFFggn+MRvFmc1mss2TraL3lAkFl/
	nbbx+RR13cx/yYStHo6T2oCuBre4jd7hZhcIBTsHU6HFkdbO4ov/QzL1V09CJbIUOcDYIVhGsAv
	KCE6e16eOz0SBs2lwtTNUU4CrHWse+OWzCUeeUkKI+U2UW92c9ARW4I2xwIj6K454NVGNjGFNnQ
	x5HrKGpmOutWo9sZoZG/i4f0GDUdLtHOWVB94tbWSq0MAWGqglfChbWwhjDPHtllHzCNPdp1YCj
	Ks92UoGdUiYY141ZfNXzZN1AjdkqWpYovsUMiU=
X-Received: by 2002:a05:600c:5010:b0:48f:e230:29f4 with SMTP id 5b1f17b1804b1-490ec4e1c7amr13862745e9.15.1781249153014;
        Fri, 12 Jun 2026 00:25:53 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea83d8f9sm47864355e9.9.2026.06.12.00.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:25:52 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ARM: dts: aspeed: g6: Add AST2600 pwm tacho controller
Date: Fri, 12 Jun 2026 07:23:40 +0000
Message-ID: <20260612072341.278591-1-gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.51.2
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It use the existing ast2600-pwm-tach driver.
Placed according to bus adresses ordering.

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 189bc3bbb47c..818d486b94ac 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -102,6 +102,15 @@ ahbc: bus@1e600000 {
 			reg = <0x1e600000 0x100>;
 		};
 
+		pwm_tach: pwm-tach-controller@1e610000 {
+			compatible = "aspeed,ast2600-pwm-tach";
+			reg = <0x1e610000 0x100>;
+			clocks = <&syscon ASPEED_CLK_AHB>;
+			resets = <&syscon ASPEED_RESET_PWM>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		fmc: spi@1e620000 {
 			reg = <0x1e620000 0xc4>, <0x20000000 0x10000000>;
 			#address-cells = <1>;
-- 
2.51.2


