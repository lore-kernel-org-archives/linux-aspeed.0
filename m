Return-Path: <linux-aspeed+bounces-3430-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05110D19520
	for <linux-aspeed@archiver.kernel.org>; Mon, 26 Jan 2026 22:56:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f0P6L02XVz30M6;
	Tue, 27 Jan 2026 09:56:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b136"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769374854;
	cv=none; b=IBUzRfi+tY/YuwVM2YJ0Tkyht61CUJeORbEOT9O/NJgqwqqZjbj/t+ZgSu2S6G56s9ERZ7Fyu/kM3jCrNJU6mQfI5moHKWBPMY7zLynCKf1N63l2qRUeFLwmj1Y1DfKt1jcAde7aNy2bhDTaAE/niUsH35Wpq7rOeC9HiICM0mWRB9IRE1YOtH1w/5otAt0T+2LDONWdXprqo6Zii+0jNk4n9elAyCXQm8ijMG1G8xpHVhq7HkLXmkUx7MiSVjsmfMKNysZuJYRFaspyVrmxvjGOEk4zfxL6tn59tAIU7K5XVxHigVPga3DpLDR6t2YFtJHJwvKakd0z/ccOlBBJ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769374854; c=relaxed/relaxed;
	bh=CAu2MatAEnI8QTVhImPBkJhxG/GJJFigkdVmzHyS/y0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rki47Pl+tBt7r9th5XUbBJk47HaasZA5kJTWqboumKnjtZl1F0gfbfdNr8kGiofBDdTZon74BC2thper1TOQ8frpDYAt7UGGAU76uzNBFM8eKCuF/yEW4WnQ0FGVRAhPFbJN2gnMg3KFk/DrXdlp4fwmWbv2W78qlqTL9y8o9p3KPl882TUtrvQKDvVf+69FUVaF77B7L/xJJQmFBDX9+lntEndZRgKF0gO4kUGee4K9XWTBgIuDVSEEom7PoIXvQzv3Y9/XIPIW0QEuzbh2/GeP2DJYCg75mKxIvI8mvlOHmIRTmvpdoP4MoS8mnHX+DKWtEEXwaf2ATUxeg2XbQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TQhb7yvM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b136; helo=mail-yx1-xb136.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TQhb7yvM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b136; helo=mail-yx1-xb136.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com [IPv6:2607:f8b0:4864:20::b136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dzkbS0HK6z2xPW
	for <linux-aspeed@lists.ozlabs.org>; Mon, 26 Jan 2026 08:00:51 +1100 (AEDT)
Received: by mail-yx1-xb136.google.com with SMTP id 956f58d0204a3-649523df010so3382232d50.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 25 Jan 2026 13:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769374848; x=1769979648; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAu2MatAEnI8QTVhImPBkJhxG/GJJFigkdVmzHyS/y0=;
        b=TQhb7yvMuLQEO6ND+y0Nln4wBz3nqi5JlR96eiGUkNJE5f8CcIxfCk/o7noIwAoari
         wltYx+XJL/nV//03Lar5NhvGaykQ8KoxHpSrV3kXm89cHppKH2FneKB+UqP6zqbFIKmr
         QOZ32aTC0cvXi+wnLEflwfKShnbBTG5nyU+LFw5lvMQsp5ylCvl+8Mjhl2EuvIIkJD42
         cciiB/b3jTiv2ULaNOEMXC62vqVu5nTpVkS/1i0sGRe2o/7E1K4T/1lMPUIRrkT4wl45
         NCkzuNIStNUPlhzu/+n4jMO0sxP796AwBowQrkak/N55T6NjzWJWd8jYW+GRh8Y9lL+D
         nmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769374849; x=1769979649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CAu2MatAEnI8QTVhImPBkJhxG/GJJFigkdVmzHyS/y0=;
        b=OdJDC6TV3q3dU+roIOLlDGn4Un34CtCFah8UhYTocgDm4nmDq/rIztpERj0/ktkJ+N
         RJ5xxeuw+b9OEboG5WcDBh4KGRAsPKoK85L2NaUVgWb4yfA6n+xdkR8M9hFRs/oIGvSd
         +cLG1ptZdBYWTCvi1b5rT4977LKES1uOqmgPQ/Beqb15i6yBXENol/8AHczjYIJ2Kpr7
         OHtn2JVD8TKGr8+ZrUz7KkNdpk7+tXzSYFyFAsfyXVe8JYf0fORt4nVYoQrj9ppNkDlg
         eDPF9zahWiints3qGPkuomWrfC7erLtavn2vkyle6naiAD/RlFXVXFd6iH25K8N73YTe
         2ybA==
X-Forwarded-Encrypted: i=1; AJvYcCVGHOjv5MTkKuzTSWxJ6P/zefujVotY+rylejtoW1PGJDGCPc45h++2IlQec7sybabwe7Mp0RDxS6wPKjE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw4MVh2ZreQxmaNjDa1WLWs4E1n2iCCkaB9rInquInVY5txapzQ
	27mKVt8z5BOhpWLNFD0TUyTIxnp76Sz1mmXCHOrdKkR8o1rucNY/Dpsq
X-Gm-Gg: AZuq6aJ1g1DQiaKif+/S6j9g3JOzGJFnVxYOwUZeu/Dnlmq40uguuFH8qN5Xbz46oLU
	49PZOklJWdFI4/Ws/L5yzVH1R5+ljl4Lk61uZC3eGriRg5mK7NfA4lnGvP/RBoLC/WdHY0YJFPk
	ssaG31eETjCPiSgdm03SIBKnrFPdD03a3Hf33aY0f1e2t7YgjkJSWW2DYOI0oOFIv27Q3COopgC
	weyUH7pPUo75yKa8/N3Q+sHlExBOEduGpWKnpM4AcO3p8lM/QEFa/ZYk8din6tcWc+3xhOhvYlB
	TjQH565/vNLrvBDIIaqU/ACtYE098TzFvQRSlkxX5SmAtJdMm/J7OpjzM3hIlk5edr8s9Lfq2xv
	Cc0HWMFHYeJ+2pMQLfmC1+5j7ZU3UUaV7WhQwTKBIJvSkWAVehnngDhgEj46T6Zte+q9a/TEEVY
	THmJ3x
X-Received: by 2002:a05:690e:1559:10b0:644:7398:6682 with SMTP id 956f58d0204a3-64970bc9f6dmr1471749d50.30.1769374848597;
        Sun, 25 Jan 2026 13:00:48 -0800 (PST)
Received: from [192.168.2.165] ([2600:1700:220:59e0::914])
        by smtp.googlemail.com with ESMTPSA id 956f58d0204a3-6496855d65esm2518183d50.12.2026.01.25.13.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 13:00:48 -0800 (PST)
From: Anirudh Srinivasan <anirudhsriniv@gmail.com>
Date: Sun, 25 Jan 2026 15:00:38 -0600
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: Add Asrock Paul IPMI card
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
Message-Id: <20260125-asrock-paul-v1-1-956085a4bd06@gmail.com>
References: <20260125-asrock-paul-v1-0-956085a4bd06@gmail.com>
In-Reply-To: <20260125-asrock-paul-v1-0-956085a4bd06@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Zev Weiss <zev@bewilderbeest.net>, Renze Nicolai <renze@rnplus.nl>, 
 Anirudh Srinivasan <anirudhsriniv@gmail.com>
X-Mailer: b4 0.14.2

Document the new comptaibles for AST2500 based Asrock Paul IPMI card

Signed-off-by: Anirudh Srinivasan <anirudhsriniv@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 9298c1a75dd13b447e5ddbc64c5e169dcd08fb15..4660b615da18b7cc390ad0cf95f5a3d7523a865a 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -34,6 +34,7 @@ properties:
               - amd,ethanolx-bmc
               - ampere,mtjade-bmc
               - aspeed,ast2500-evb
+              - asrock,ast2500-paul-ipmi-card
               - asrock,e3c246d4i-bmc
               - asrock,e3c256d4i-bmc
               - asrock,romed8hm3-bmc

-- 
2.52.0


