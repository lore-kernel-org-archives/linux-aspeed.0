Return-Path: <linux-aspeed+bounces-3456-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99CDD172D2
	for <linux-aspeed@archiver.kernel.org>; Mon,  2 Feb 2026 06:05:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4GM375Lhz30FD;
	Mon, 02 Feb 2026 17:05:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770012351;
	cv=none; b=ArnI7DNTGX87rv3LTxzuWuA60JgYi6l6xWeUAR/A3oSlhBqNd+M6u6vgnWHgWwhqRkFIM89E9Wwe9nHtOskxQDkC9u6sqB8lSzsELuHrZX5dcpROM2ji3tXvRIkVekW/vCliq0mhUYP6byO/ikmpWGvA8l9dnE3cM4EqgEOM/aZqNUTm6FxY0tOZd5kLm5mQRg6pwXLs0vRCEk3zNkXbzdNo7cefCPAQLDMEZkSiZ6n7FiNx2aMHEy6YXTBXRHQDbpzS07d197J3Bv7j7o3HsR3KeUd/G5hM73z7JjC5Hbd1jBSkl9EJc2l2+P1ow1nuEYA2WvPPwb/afBdBu/awAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770012351; c=relaxed/relaxed;
	bh=7cFeh0F4AhLzGOrxCS14dOc5yv3VBPRg4l3srErLLzk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bb56FZz23St6tkzPDfFXhUjUoqg2cNojfiLRNjOyKzT0nyP1KGWfeRdbIJynrCWXU+WbSQklYweNUeYFmxW1N8h+hJq/SUw8CrhYbwst90d+1sTtcp59g54srfl4r5emQfMaf//LJ8coiXb+k1fJYIiit6wbuKHS3uVCxx+qXCWwg4SSaWQT5Cq5SQgyuMRFVL5pRroSEgIUbQ7UQ7rlejRbAnF/sH+nyx1DpFmMe6HSIPdyBzZiqKwp2xmNRM+nlENfFM/AnPhjv8DX7D7jHiGr0xtJ6LX8YFL6eSH08mgbY8kBh+/rqpv6BlntqR7TKedBy6hAEScktoM6zUO7mw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ksBKqxsB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ksBKqxsB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4GM24QdXz30BR
	for <linux-aspeed@lists.ozlabs.org>; Mon, 02 Feb 2026 17:05:49 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2a0d52768ccso27014555ad.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 01 Feb 2026 22:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770012347; x=1770617147; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7cFeh0F4AhLzGOrxCS14dOc5yv3VBPRg4l3srErLLzk=;
        b=ksBKqxsB3f7mUgjTT798lpe17CTzWZbwmDN0kq9H+tRZIqkzE2mYnTp+4QuK9Q8cZG
         CkUDWxIAEbExLb0+jlF5e1zAq1pVu0bTohsFil9i/df5CdmhGXnOCuwQnV8Jum629J2o
         CTQfMB+RPpEUSCVQ+f5jZwIcRyaTF3xELFAW0MR8E81Thcvthth7vdVWF0J6HJWEaGRm
         CZiDgYBGWnfEcyXJQUoKwvXlYa+Ix7He96Y1+K81Pu1pAix3vsA2rvdD/p5QTZ/bpTiV
         IePJVZU3RQSMIeLZUtKfVVHm0aKi0QFQcTES7c4O+bEzbXoKULvoKsZkigXIm5i/rGAQ
         TIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770012347; x=1770617147;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cFeh0F4AhLzGOrxCS14dOc5yv3VBPRg4l3srErLLzk=;
        b=YPL4NWkYhHmLNkpqU3ipOtcaJIKSl44UAoPZxkZvLNEiAKbg54julVUK9aaQxn24il
         waL5A4HUG7s5y3eWaRSzWoCDTz5vsXnS3BuGnq76euDjKcjtgVaaS/aurbZGgkaEdWxL
         2ICu4RQA3X3r92lC9XR3WblF7QdxexGFJYzVCbW/7v2sksFrm+Faf6nqd0hRRC/s7cs3
         YGzS3WPtyrTSwWtdC2vu3PJ7pkm2Id9hzEKob/gU+0DZYfDJxigKJYGsOo/qpCRSylqU
         6jIi9G1yYF67ua9wUkyNRCcDMeBNqJlZN9VUVWGbFOqrCQgjc/9Fjm261NhIH5GDclDl
         6u1w==
X-Forwarded-Encrypted: i=1; AJvYcCXu/RtlMp1CcAUy/GJIzvJLBnIPCZLe6mNKM8NFq0cy/JjYi8L7LP1avXa6iNl69HfosYmr4Ug5/vOjvCg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzme/o+U96E7QF6eZCcytsw5WoCN1ccDvTPDBP5iCfawX6ifGK2
	vGZuSrTYABLg4WY4PX1mqaJ5DFjHJNHid9KOWJ6GJM8B+VEZKN1EYeui
X-Gm-Gg: AZuq6aJnj7G0x2Zim/g00hojYmu1dFffc2X3u2OrdLzhZAA8K90d/SVDsc3YpE0jINp
	mfME9fC2gGvBkTMnmm9iMZq0mLPrZjJMTLKQa7QSYIkcGg/rg1jJt1jvuq34azSKlNDc9atttEA
	HdH+brc+c810eANB87P6XtSZG9y70MLV6tKTSQkkwWUvQVLUFq61IPpqmcOYHh2IbFnV406XIeD
	YEMnsEEhBHrXm15plZNwlVuRJO80mw/vJnWY8YOCTzg279u4ne8r5aq5d71iKTQM/yM79MMe/ZT
	sXBJjS6Y9dbYvOKnPBbldqj2Y5ze3paaTojdtU0V1X6JvAHtdQ4nRnPMpV6z24lybAPR6RGMWoW
	Hohfg0IhWLwYqf2RajOP5dmxhYAI1TG3dfA0grcfoFg4l2L5/CA4JFiYHWPN92AL0J5TY93fSwi
	7ULXvz2NraJGgBKlDG7X56XES0B0/buJ2vQnkMWR2R/7tvM5txJ2WpY5kLaIscRHc=
X-Received: by 2002:a17:903:f8c:b0:2a1:3ee7:cc75 with SMTP id d9443c01a7336-2a8d96b0b3fmr102479305ad.19.1770012347504;
        Sun, 01 Feb 2026 22:05:47 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d99eesm132926135ad.78.2026.02.01.22.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 22:05:47 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 0/2] Add Meta (Facebook) SanMiguel BMC (AST2620)
Date: Mon, 02 Feb 2026 14:03:15 +0800
Message-Id: <20260202-sanmiguel_init_dts-v1-0-c0023ae41899@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIACM+gGkC/x2M0QpAMBRAf2XdZ6uZEL8iie3iFqNdpNb+3fJy6
 jycE4DREzK0IoDHh5gOlyTPBJh1dAtKsslBK12pBMmj22m5cRvI0TXYi2XdGDsVhSmVLSGFp8e
 Z3n/a9TF+tv5nHWQAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
 Potin Lai <potin.lai@quantatw.com>, Roger Kan <Roger.Kan@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770012344; l=707;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=n/w//Nuxlr+/ykO3WHyVzyFaLLe6UAbemJnx2mm0Xvk=;
 b=WdN+eQh0JqxC5Ye/37ngcek31btboBmbn5k+V4pSQgqp7f8zakKS34ssJuZjwoH8vmU3r3F03
 NItOTLQGf9SBp0ZFjAdmWh6kAve3n8zOUhbxxD8tZCEeuenYy35Tazx
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add Linux device tree entries for Meta (Facebook) SanMiguel specific
devices connected to the AST2620 BMC SoC.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Potin Lai (2):
      dt-bindings: arm: aspeed: add Meta SanMiguel BMC
      ARM: dts: aspeed: add Meta SanMiguel BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts   | 1163 ++++++++++++++++++++
 3 files changed, 1165 insertions(+)
---
base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
change-id: 20260202-sanmiguel_init_dts-79cdb33c50d5

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


