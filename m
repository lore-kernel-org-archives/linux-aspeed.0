Return-Path: <linux-aspeed+bounces-4992-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A4CC88E75
	for <linux-aspeed@archiver.kernel.org>; Tue, 15 Sep 2026 01:31:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkPcc37lWz2y8c;
	Tue, 15 Sep 2026 11:31:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789435888;
	cv=none; b=BpavH4ryl3iI16WssAeKPFAZFbR2gw0NFbVwNL+Ogu/7oGfML4XabcK160B8GxtZKLhxM3+il++yxWc1I8verWgNhBWGfygqAcYjXPozPtbe5YQ3uk4nWe+wZfynp8JOnj30Iyl4jxNJdCrvFvJQk7Q4r8KXDU7SrCEkZ9lYjmJ86T5TrdVhglys/k2RhBGpGQ8sAJwcUD/RaYBX+wFGIhP1as+6Cpm2vORJqkZWT3ejxNMMRH4hTpC6wKh3XtCYcCC4Sm1TyBzZBynToHp9mOGFXqjeyYlUeYZcrz22i7caohEFvinJQyWnmQMoUnW/2naCOymZ6sjiZE4AI9Ud9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789435888; c=relaxed/relaxed;
	bh=AOdg97xUtxa8AhSsk3nKT5LmiSCoT1EL2eRC7gkp05s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GU8Hxz44DmvhSYs2N3UYwABmQXuBlfHlg309u8tb750c6tRdwC5PlddQu9NBLH3f80CGY1yQS+IPc/vN+WS0ZTCM5dWLaFTT/Y5Yo2vMIkyKbZmZ8VBE5Wa+sLvojFU/HTHC3EvllKGGOx+1Qp8G9C98LCOgIS2HqY27Rb4zeaEQwxgyosAvFjYo+hNfkIX3avFpIfKtiD7AzXS41jX6VqWh1z+m4eunxmZRnparGfq6yKU17oswfPVBMhVxMd/3tFr2Dj5VISjKoE5Ngn4st65SNsiGQ34RDTABE0hogO7e3yGe702msD8tSjVFEYeJrqbZIJxkifcm+Dp+c3ELzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SubS1hAi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SubS1hAi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkPcb44kMz2y7p
	for <linux-aspeed@lists.ozlabs.org>; Tue, 15 Sep 2026 11:31:27 +1000 (AEST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-4c5373b1138so2193131b6e.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 14 Sep 2026 18:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789435885; x=1790040685; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AOdg97xUtxa8AhSsk3nKT5LmiSCoT1EL2eRC7gkp05s=;
        b=SubS1hAiolWkARPIjEv9Qp9lmH9WBEdtdnf2t35cclkbOSmxjhwaiI7DPAg55VCKRb
         4SiGZ/0Ss3XoqWnEnV0cF6wT88D3+ZBX2qG704KoFdobclDEcOQbelfkqPOL+h6udh9j
         5D2GvqKmpW33n+x+dTT7jAXwve4qXkw4U6JBh87WmFKCn7tA7l1D/512Z5N3K4EjmWPT
         r6/3xh9GbKtpWW9PDRt8ebH6cuKpSTa1vk2wbfumXaFlNfMtLcuBKQ/Oq53bl7iCWVGb
         oMMzO5icF5G1Fg8wUZ706z1ieSR3nd0uUu4hvon2KHjfDdMgz1zVrr/NDxn38z+DvucG
         9Vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789435885; x=1790040685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AOdg97xUtxa8AhSsk3nKT5LmiSCoT1EL2eRC7gkp05s=;
        b=PHMre9X+UC04hW6ZSuIL6euvQYMrZQ6kZ89AFaVjm1CEKTuvgM9+/b4sLWJ3vIJDhl
         eE3USOlKJhxPKP8kWves88qjMwJPy+gaEZVPoB3NCDGPX2cxep9D9vvl8ReJImP/SEGy
         eebn2jeJIs1TfUqiGN8zfU+GOtkj1s07CTzeCdVOl9fSxfe1SYBlOvYWFpM9ewc9oNSA
         1k2BGeO3UFnUpL8LNAicfzpBzrfRo0t4ChvOww72gFHVyR8f8PhF0EJDWQHbw0ksgct5
         k/JN5MpwwY7KMNX1T5hLlyzk6FIkPLnqE7Ol3V8uGQHlRWfR2OfJTwCa5IjykZ53DZGz
         AV0w==
X-Forwarded-Encrypted: i=1; AKwUvByYWF8cD5L8FUFk6EozELXfZKwPVvdE5ee1A9FMmDl6jJzgNG94K/oWaANRwhHoX5ecv6MjOH2ZQCBggS4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++npVXlRnOBun5kH5/yHmSwDnbiZPAxmilb3fLmCaV6GDruGWks/
	wGfoym/RpcUaor04QsSmKrVDEz3IZxiNLsdcINhHgqOQLTbkCcmT819I
X-Gm-Gg: AYBFou2hSKBAaCoRNtuS/+0lKjk5xxlUKz7WEgKvjN5CFL1xfii8gufVb/0NPuKp/cp
	Dtc7udIH/KFSZQegq+YzwBkhht5ifL1kO62OBKTP8/a16MiyOaztezCDdjm1HHaLzTPzeY3BaOS
	rovA/rtQn7P1C0UB5bjNN8JD8KuclOwXW8GgaSupJLhkT+pjdO2fodNjrgTkhPNwzpUm1b6sZEL
	gMLOAh33fSoeucz1N8269NFk4OCUOxtKZKQu3SOa/l+UiZTs3Z+h2DvH51djEL3uXAElDaeFpbH
	1bi6Z+QUO1dShzBNwvotLGsyMenAWf0G6fSZuiqYXunvboMIbbtNVd2Xf6RN7jT3sn8DSOPMRtF
	DB2pVlFZAhGbESggv0zP3itVDt5u6mrjgIvlfQ2F2ezY76zT+67kD5cMThpP/WNb8jldrP9zOyf
	Sg5rJrPL5d3EaR/33KFk4oBtdSZkGUWPqPPRriY/ddou5f/hpi9K3i/I0q2p9gr1Yq0ZFQPLo7S
	eCu3oBMIh8WJqNK
X-Received: by 2002:a05:6820:8119:b0:6ba:3635:7ffd with SMTP id 006d021491bc7-6c543112b4amr3036635eaf.64.1789435885128;
        Mon, 14 Sep 2026 18:31:25 -0700 (PDT)
Received: from debian.prasanth ([103.183.205.11])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365a59b18sm27111575c88.2.2026.09.14.18.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 18:31:24 -0700 (PDT)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v5 1/2] dt-bindings: arm: aspeed: Add ASRock Rack B650D4U
Date: Tue, 15 Sep 2026 07:01:09 +0530
Message-ID: <20260915013110.4780-2-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915013110.4780-1-prasanth.padarthi10@gmail.com>
References: <20260830182036.284736-1-prasanth.padarthi10@gmail.com>
 <20260915013110.4780-1-prasanth.padarthi10@gmail.com>
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

Add the compatible string for the ASRock Rack B650D4U BMC,
which is an AST2600-based server motherboard.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 9ba195b8f22d..4c9e96801c1a 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -81,6 +81,7 @@ properties:
               - ampere,mtmitchell-bmc
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
+              - asrock,b650d4u-bmc
               - asus,ast2600-kommando-ipmi-card
               - asus,x4tf-bmc
               - facebook,anacapa-bmc
-- 
2.47.3


