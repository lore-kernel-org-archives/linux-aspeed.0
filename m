Return-Path: <linux-aspeed+bounces-1532-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9642C7EE2A
	for <linux-aspeed@archiver.kernel.org>; Sun, 22 Jun 2025 00:01:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bPrw7498Rz2yqn;
	Sun, 22 Jun 2025 10:01:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750492297;
	cv=none; b=fBU27qFLX6Z4b1edi/h63t8OFa4CzXswOPf7Cip+B3GNO7k+PNvo8TEL42O1ii/8XZaaS3aCxccbrDJ+kro7knnlP/YLjStOjyZH3vdvPK31iUolU1qp7NTg+q+MnhJj5oSG0TzpQpeFGG3kVgTPmUDeVoui999IG9UJF35ioRtfLsmLbp3G9ahBL0AGKiHTYRfpQiHPcx7Dc40JdxCsZjixHchLdI0OMXy9sS/PSL9uHxHaTqH+70d/JWthFZ9v3R8tHSskYwAt4jAgqHSUafRt10SyTAESEz6/oJgOcQgnhP/+5nlMwRnnkZhBjLPwYE+rh3qAWHN+Rc6VmM26Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750492297; c=relaxed/relaxed;
	bh=SKbBTi7IDp31OkTJ6cIcfFVheRI1s9qIcPf1iWX2qRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oq+HKN0knh46o5CRlVBexXNCKZzw4laKMmSTXT6yJowskvwIUZQ1zqfFq4MFh52Nf2Wy1Ig7F+fotHYJkqsLeMM40/r3NN3c+4l2OsfygEZuuAIQwGpnD4VQkg0BeM/hD+S5PwWNKaQ+/k89o8GuOHihFZrdBX9K2pAwN3bKkRYM/VCYewmCZbx77KV1If7Jb1nUeVg5lJ7jPYPFL8tPEmoLeVkLVUdD4whicAmZD1AdbqkBfy8fB6vOaBDDZP/EFgw3eYegJXPUzBYu/gPG/fxDr0X4hOpZYSXb35CyYPYGJ6OL7Hml0yqjFZoisgCmGRcDuxzynbADD0+6/EBKlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=N1ifoDF5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=N1ifoDF5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bPRPN4Rfvz2yF0
	for <linux-aspeed@lists.ozlabs.org>; Sat, 21 Jun 2025 17:51:36 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-235ea292956so27807835ad.1
        for <linux-aspeed@lists.ozlabs.org>; Sat, 21 Jun 2025 00:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750492294; x=1751097094; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKbBTi7IDp31OkTJ6cIcfFVheRI1s9qIcPf1iWX2qRU=;
        b=N1ifoDF52OQOIIt0nI8yV5tPMfWUJ5MFrofRL8FyYlh0nBqvivV4f7m9DIGEQFzOLl
         +8fObX7m2NEl4QGwIdREkSm74JL+GXUBJM/viggzSll5Bb5BQz3vnzWI1sUGhlGtbiij
         99HEx/1XZUwkAu/OHckbyfADCF9ZR4t2kK/xb3fglz+hmrgqzBjsluZqPAQa4wnEeQ/+
         /0AjpGoQo1F7X3NHZrGsuFbwGIe+DhN3WAcdySN6Tl9QyLWdZ78S+wG7ampH/EygHOjD
         9Jpe2IhT9TrJes6LJVxxSuUGSeZZiY1E4+SEkSO47818PlywJVDxjWxa7D8IUFlLvjg0
         nKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750492294; x=1751097094;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKbBTi7IDp31OkTJ6cIcfFVheRI1s9qIcPf1iWX2qRU=;
        b=cdWd0WmtZdSiQVA/+AJ4iOegQY5H8DwpATruAzpLCROf8qVK8WRzdDpUI2ghjCL8gT
         uSFI3sjLPxTawLG8R94M6Z062qPIbsLAQCLSQeas3IrDfFT6r8VaARmV1+bB2Dde7XWN
         FofZPcJ/vCY8qSTYjLdr22+w40KUkoydSqauY8v5XbBI/UHds0+ONOj3JfUg3lRQPDkM
         5u8HrL/XAhik8Xv6Wj4nbbW6P7qPWEfu7a0G4Gesj4Gt3wtbq/B+31pMQwVGCeR6JaiC
         hd5N9bMDbm2RqngWKLNOeS7Zgg3cqGNW9PWyM5r3ZODOW6kiNcFJuN3Pt46RK+1yRScY
         BuLA==
X-Forwarded-Encrypted: i=1; AJvYcCWt0H0xXzXpZ0ltFbmlQZxvWJsOsI6zsC+THjk5DRGt+6k/YFkr2LrnIBzC4CozBniiQXIb/OUsgrYO+rE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YypocLBEBNAJUnJhQH+ugxReM+x2Omq0AhE8NihknHVn0zaiAuP
	Kzyoe/oxVzdccleEQzrB4J7kYv281ibZCzFVWIrAyWSpOOvLqwxBcfj8
X-Gm-Gg: ASbGnctVnF4W124BxCNJuMlzQs9je1pOpnP2WNwG++dL2HEaHn//YYb3Gy1JwSggwE7
	5EZsPV19WjhLexxPgzaJc2P4E5LGohIYr930zhxKWHq4dOnHXMRe+1AKo4l3yvpe1xIb+CXj9jC
	zjGGNqeNsH7u+IQiLq2nZ9e1Nr7I3FTHjO1J8lqp5fYWIaAQicgA7/2KaGRoUSWJIlLflHHmdBR
	EuqibZ/vblO3zE2bHByOIZFukbJNI6gYhKZtJSNbHl/iFNiMagFu0/ARMX66Bysd26WVz4262t7
	ifuUFkZLSXFXoiDYEc6XpwgnoLJ5HTzUuBhw5+61CFsZII5mLrFMmtwukukuDuO7hT6gONX9l4f
	DwgWsT0NW6SuTbdxengZRyzRRusRcGkI=
X-Google-Smtp-Source: AGHT+IE3lIj/203gOa8XTRN8xFQrZ8cA/HMSLP//zwl4/K0OX3xxlSIn7UAWFQ85jKtLSnVzoak0LQ==
X-Received: by 2002:a17:903:4b4e:b0:223:f9a4:3f99 with SMTP id d9443c01a7336-237d9954dbcmr99624285ad.29.1750492294103;
        Sat, 21 Jun 2025 00:51:34 -0700 (PDT)
Received: from [172.17.0.2] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83ee9f6sm34823025ad.73.2025.06.21.00.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 00:51:33 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Date: Sat, 21 Jun 2025 15:50:59 +0800
Subject: [PATCH v2 1/2] dt-bindings: arm: aspeed: add Meta Clemente board
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
Message-Id: <20250621-add-support-for-meta-clemente-bmc-v2-1-6c5ef059149c@fii-foxconn.com>
References: <20250621-add-support-for-meta-clemente-bmc-v2-0-6c5ef059149c@fii-foxconn.com>
In-Reply-To: <20250621-add-support-for-meta-clemente-bmc-v2-0-6c5ef059149c@fii-foxconn.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750492287; l=886;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=jaJuRFuiQIpQeCgkDZC/ZckoYXAyyJRWtir3QL+VwYw=;
 b=o/ivUb3h2VmdUZCsXclswk/7ebeMr2ftIKUaS3uY5YVto790ke/jBbOCn9b1TS6JW3H83cREG
 xmBm5Tfnhn4AVTGa8+huWqdiYOWDEsu2x9mowKz9yGkID3sl/9dRRQf
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


