Return-Path: <linux-aspeed+bounces-1598-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71829C83026
	for <linux-aspeed@archiver.kernel.org>; Sat, 28 Jun 2025 01:56:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bTbB370Syz307K;
	Sat, 28 Jun 2025 11:56:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750993193;
	cv=none; b=Ab31ItfRUjxzBHP5N3qy9/XrxmimCd1ODe6ldUjhT4kY3srZE14gAfY12DOmrEI0NHWLihG2g56mgzWkQyT0HSfOcL4Pk8CGM1wNA6QlMpEZ7j91DIZ0trrsVSWKXlc0PIuCGZNzm9HNjAZhxXKDo2hopnsvvbkFLccnRihuP9aDaao4Ltm0gjdQYR4jLQ0UY7Q3cYLR8mxPF8PtPPfyiJzlx9eNHEGaFz3cQlt2lEN5o8hq5IPu0e0GMJiqK2zs7M0dV6ddqtbDxwaPMzDYnmsBo95nAHyUobA1mEVWS535PytbNiuNnDBdpNwaqJNHvEM1I+iT8/rib1tQnIEPQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750993193; c=relaxed/relaxed;
	bh=SKbBTi7IDp31OkTJ6cIcfFVheRI1s9qIcPf1iWX2qRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d6G1++3a1yHv6gJ3/B5R+oiV2POPwSA+PqCcXsocEFOY/0DiPBdQQqazzH2S+uRhtNq6NlOUH0qUtJ+0cUPAi8ueajF2K0r/AHOLG0jGyn8Q0a7QKT0ai3t01K+zY44E+uRgDPbD/cxSt31orf9iUdI7vYCXMqshm6vblqL0nmAvSVPgvLNUEf3LgUO0tfMWnOTbwUn93BVllgFBHiH7UitIWWDICJKmtpHakV6744MRUz92qVOEauHgQay327t2uj/rEj4p207BmmxeD4HpYIqg7MHM2BI4j/pOoRkVpaN4gwmn4bWMiHCH9/hnQxzJqL6XTG929jYHaEowt88WIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dKPCz+wL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dKPCz+wL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bT0f06dCFz2xCW
	for <linux-aspeed@lists.ozlabs.org>; Fri, 27 Jun 2025 12:59:52 +1000 (AEST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-b31d489a76dso1511583a12.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 26 Jun 2025 19:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750993190; x=1751597990; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKbBTi7IDp31OkTJ6cIcfFVheRI1s9qIcPf1iWX2qRU=;
        b=dKPCz+wLgmJSNpS9QtB5hhan0PzG5iTO4qSOZXQfTDU+XUaUY5iLX8qw1AnLierW2q
         4HfMot/uwXOhyS4Wtd7uCrRHTdP9M0PhnyGzSv5YyRgJSLn5ruXHx3XgncMCq1K3DOaw
         LQvDx+v4ecNqboRwJv7ZlQMegUiXMyudulkyXHS9U43DYr1z56AUimfuEGloNXZ6EtoJ
         WXQ8ZhhZjtumidtNN4o0RFjPZ7HithhdTamjFBorOIfx4cTsf2hwrY1N60xH+fclc5qr
         fpj+5Z78G8X1PgaS6wufFfZrpuYhc+pPzEUlZpi2HJI0Hi9vzLuK8ZZNIPn5w2guCdVs
         sv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750993190; x=1751597990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKbBTi7IDp31OkTJ6cIcfFVheRI1s9qIcPf1iWX2qRU=;
        b=I1aziJIt+ifeYh+xka/ZV7XNI+cymYEMVJtKvXzo2Xo6ltdjaMekRNd7kkTYGjeKtt
         DibRqohuzwWgjENW2Do/MWtOrryPqdxauJnzG1QGijotb3RShZhZOFi2GzYSbsvBJA23
         79zF/YW6eg6BcMoM4hMq1AsuwdOQXZvQeYGMyC9NL0ppxiuCQqmvsKLD5l/4MyF1VY90
         NnPojAAUmLMEu+cZyNHpiG3fc/NKkOGj2sTxobTVEvXXKfl41y+LrgjuoZT/8ApFNKQ6
         FlfvW4w8blmmTrMER4Ee8ZDnUNlVwX6ncv3uOoBz07Qsknj6IXKH1QgMyl90pRe/Y9ho
         NoWg==
X-Forwarded-Encrypted: i=1; AJvYcCVIEMkkz/MuVWUItiJJhC1yeCj4SbY+7IPHEwYtj5hA+hmLwysOwCPYG169fkOcbL0zPEolxIlecKkF24s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyQ1952QlAEnoMlStwHNPRL9enFxknZJXfKizfEL5Bx+OYogPgD
	mwV6Ms26+GENGzBF3ZYW1spAtqwnPs4SCP3q+LI0if0bpXrS0DK0ZwAW
X-Gm-Gg: ASbGncvsOtO8uD2EmPCJHMMpO4tWSbr9FmsGymcDs6KYZxA3dhMB9ysk6sYgMbziIQo
	4ZLF+82rzD0OanM84k+dQfJlr595omw8DvjrWCnsa/nbkzUUljj3QGyyQ9CNarBEVwPue5GMIG7
	Jkp1z669OdrtOwKQZBYnZhp3ArDw7Xyt2hF7SyObZ0GR6CRlXtQiGjESkUJJURxOip4E9vrhQGy
	c5dIolqE7SGre6MlautNLWd91kz1j+EEvrlSalgv2z5Ru74gdkXJEuj0kRQ1Ll2vvAkEOtgShCi
	ZWAD+tv5l01Lcdywea/dLp6ZLJolcicEN7fALIWYFVA0EZP9+Oik/yELqHDMU7yLMp2eYnUPeuq
	/048pUmeVzgEkpqtza/6opZTfmzBc0WoOngYBFYHTjw==
X-Google-Smtp-Source: AGHT+IGKG91ljITMzoVCW+bBbL43wOYsdAmeiGbGiZjPAqk6qOf9V5tPOGCVNlv/03ppyEr4tpG14w==
X-Received: by 2002:a17:90b:5212:b0:311:e731:523a with SMTP id 98e67ed59e1d1-318c8ee570fmr2178372a91.11.1750993190514;
        Thu, 26 Jun 2025 19:59:50 -0700 (PDT)
Received: from [172.17.0.2] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5426bd9sm5358186a91.27.2025.06.26.19.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 19:59:50 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Date: Fri, 27 Jun 2025 10:59:02 +0800
Subject: [PATCH v4 1/2] dt-bindings: arm: aspeed: add Meta Clemente board
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
Message-Id: <20250627-add-support-for-meta-clemente-bmc-v4-1-ce7ff23460c4@fii-foxconn.com>
References: <20250627-add-support-for-meta-clemente-bmc-v4-0-ce7ff23460c4@fii-foxconn.com>
In-Reply-To: <20250627-add-support-for-meta-clemente-bmc-v4-0-ce7ff23460c4@fii-foxconn.com>
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
 Leo Wang <leo.jt.wang@fii-foxconn.com>, Leo Wang <leo.jt.wang@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750993183; l=886;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=jaJuRFuiQIpQeCgkDZC/ZckoYXAyyJRWtir3QL+VwYw=;
 b=AYHEHTRIFy88S1GjWZDWK5NLlxMnwupBgtb6qjRHYkPO4trM6o6fQKG9w+vESOZJ2Pi2UwYu3
 5RmXtrrudpSDo/PwJ0dJJo50AxHwE3iiQYAc+uKcT3OqY9VjtELAt4s
X-Developer-Key: i=leo.jt.wang@fii-foxconn.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

From: Leo Wang <leo.jt.wang@gmail.com>

Document the new compatibles used on Meta Clemente.

Signed-off-by: Leo Wang <leo.jt.wang@fii-foxconn.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 01333ac111fbb076582a6c0e801903c3500b459f..ff3fea63cecd99ec2dc56d3cf71403f897681a98 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -81,6 +81,7 @@ properties:
               - asus,x4tf-bmc
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
+              - facebook,clemente-bmc
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
               - facebook,fuji-bmc

-- 
2.43.0


