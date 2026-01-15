Return-Path: <linux-aspeed+bounces-3351-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BC3D46634
	for <linux-aspeed@archiver.kernel.org>; Thu, 15 Jan 2026 23:11:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsdz96FWBz2yFW;
	Fri, 16 Jan 2026 10:11:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1136"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768455096;
	cv=none; b=h9j1tuV6iDBb/JNHLUkqWdFJ5xatyQNtXfaCPt9c1aA6NanpqVTtTaGSx+G5nH3PDH1wrKskOVgDsVBxAPHvt+3s6bYA0/axpYtPiKhKFTHEfFStTFhIS6whAq3FURMzpF4lC0PFvNDzQESgNpXxqV6jyt1q2DkANunpvtvMX37Fl0gFwjcvo54JTquwuTacEu0SnU3wPeZD1LojNNkiJakJU3H2wpslkMs+FQaDmFwlxHDVu1KDrBVgLgc1B4aPliuyRTgYL3urjvsfb3Ub2LgOmUk08dLTfMI1drk4ND/7aVk86byPqn+YUMzA3YAM8elR9Rk1X0WjP57WQ3ECfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768455096; c=relaxed/relaxed;
	bh=CLWjl5YE/BZTrCnvKQJ3D1RjaRhW5vGK+LI2NZ6PC+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K4pBXnmSavSRNylKFpr11MGCA6oD2Z+h62hOyeTUQutJ1c4/Ek7XO0A67jXSt+Vq7rvNGtHxTQ8ZLoRhErHlyET0LWCrlVstwsmqKPa0ekze9ij8Vx/ttTHyIhKCLJvx4KnJcEMlSP3/2z/5gAAYiUh8AbnfdzC+c5uvYSkstMkCGjv/42XaowTNTgfeTyeaD3nqfrnj+PlBW3CSdnVbzfdEYeZFLOlEUej1b5H2sw0QUkpWIIBhQgztM82S1jTSLWLJbeqW2zs7idE3Ebi1iM5uCD0C0/83md8YXsaTREDdtZ0VsjvtTSnLAnRtgOWMjmw8X/UhNZQcKdH1XbRE4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UDj3WuZ7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UDj3WuZ7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsBRq3Mjvz2xqj
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Jan 2026 16:31:35 +1100 (AEDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-78f99901ed5so4668767b3.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 21:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768455093; x=1769059893; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLWjl5YE/BZTrCnvKQJ3D1RjaRhW5vGK+LI2NZ6PC+I=;
        b=UDj3WuZ7nKvn3Lz3dTYGAACWPuzUWBie84EsEmfy8ME3w6RMIzUhYRC8piGSO24r2c
         UAfIPtiny7w7tM6LvKogFDC//P1SFcQhAf0FBu1f2yNpBYcw40NivlIYgI5Y0tDp+HIi
         XCLuteXxI6nY0i3iCtk3eDUXFGd+XI80b9bRtNCpQiHs0Si9BvvO0OcVCpcXXSddxFe8
         eqzXhs5tDQa8SSOeCF4Zoo9xU+X3Qiicfz/cOjRcvNkDYsKiuHg1SeC3c39cQic/FWl7
         fxxDuQUdBJBSwpw/QcOUYX2jcikNHnHpq7WK2UUfxPp36dYyDKNwUgiRrbieSDgGythw
         BvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768455093; x=1769059893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CLWjl5YE/BZTrCnvKQJ3D1RjaRhW5vGK+LI2NZ6PC+I=;
        b=WK5yNAlggIrmhkmgNHT5Oduiw0lhw+9JNsTm7CAjcAleGfTt93HSByORYOsIoC+XRt
         qmrhiM0wZ3uYXMegDq9S8uLhK6V+ujnsv7f84jbJQ3+uagbewdOw67yHcQl0LRn6cpqu
         7ijUXAJgr/IlUXtulUHbC0AMjSTfpNfFsQbOCnrWM/izVpSTKsxXdOK4FwSPQLrwVTVN
         czvOYzHzV+Evyjc5LqaT3v9DyFXbmBMBEsGcLbvrtLymU3neIwI26jefwyxPSg+e4Rl9
         YGkgrB75leUaIQduoAks8bNwRbi27gwWWXhiw5RM7I6FewCEHWUz2cE2gRGiP6vwoRTy
         Qt2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWr41PC0kTiCdzcx/8vg9DN4a3HnpfHz4ILyi92+/3DP2tDvA8/kN2QJ/SV0IYkbYPGLqNREeAX2nnj7w8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyl276vgjD9WYmqj1o9lOC0+CNqQX0bLwWPABEx6hdTqpsYqqWq
	eRqfiarC2pfgB5UOe3B+ofHPardbek+cfJD0Ja1Ug2laEkl9TYJg0uOc
X-Gm-Gg: AY/fxX49x5EGSHVNjPki3+v+hQMtxdTHaHvGOyEt+ZW1SwD/TW6m1ygp5GlWq9mNB3X
	ZExMm/H3KyL4MJQ27Eb7icdXF27X8hTK/0avGuQ450CNeu+rsknSsN/D4gQk6xr+BSDRJ+rgbuN
	saHZnQAQBDkU3XdgnKiMVIP+ZrmuX84Vwa0Et4flaAaewX9hpZWD1WeVyILrzcPxxHXR654yxdq
	xbnSiIHd4CNCIsBBCOMMOCxjI+tf2OpICg27GbFhRIqOwpu5pVNhhQLpsaEm76F6t+AYzRK4Rln
	HDaEmzxLJSPeiLQ/3amWcA/wQSRu5JtVj21PNAdwE1/1vwwT1G5vcnunEF6P0QWF5SMOchDGDkx
	eu1En1SKYikbpRgsivKtWSc/vIHssCFMBqZBjbEoUEvHzoqzgpbGmUfE/K1XJjLzgHSc9mTMcwZ
	W4p+w7
X-Received: by 2002:a05:690c:d8a:b0:78f:a616:7b99 with SMTP id 00721157ae682-793a1d9c70emr44480757b3.49.1768455093187;
        Wed, 14 Jan 2026 21:31:33 -0800 (PST)
Received: from [192.168.2.165] ([2600:1700:220:59e0::914])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-790aa553172sm99259437b3.11.2026.01.14.21.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 21:31:32 -0800 (PST)
From: Anirudh Srinivasan <anirudhsriniv@gmail.com>
Date: Wed, 14 Jan 2026 23:31:07 -0600
Subject: [PATCH v2 1/2] dt-bindings: arm: aspeed: Add Asus Kommando IPMI
 card
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
Message-Id: <20260114-asus-ipmi-expansion-card-v2-1-12b72d20a9b9@gmail.com>
References: <20260114-asus-ipmi-expansion-card-v2-0-12b72d20a9b9@gmail.com>
In-Reply-To: <20260114-asus-ipmi-expansion-card-v2-0-12b72d20a9b9@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Anirudh Srinivasan <anirudhsriniv@gmail.com>
X-Mailer: b4 0.14.2

Document the new comptaibles for AST2600 based Asus Kommando IPMI card

Signed-off-by: Anirudh Srinivasan <anirudhsriniv@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 9298c1a75dd13b447e5ddbc64c5e169dcd08fb15..2d5bec22387be59737474cb04d0c5f7bd589d1fc 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -79,6 +79,7 @@ properties:
               - ampere,mtmitchell-bmc
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
+              - asus,ast2600-kommando-ipmi-card
               - asus,x4tf-bmc
               - facebook,bletchley-bmc
               - facebook,catalina-bmc

-- 
2.52.0


