Return-Path: <linux-aspeed+bounces-1068-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B5AC36000
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Mar 2025 16:50:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHvp40Pd9z2yrS;
	Thu, 20 Mar 2025 03:50:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742403003;
	cv=none; b=BIVpGeX0aiTYOhB4c3hRMceDrr8Rit0tkV02bMlWNda8uwz20Z0b+mVkMPsJQ8SOwpQK3D/zIEY77xx4Hkw4JcnlOckRL7kg4T5baOhI3ifYMidArfVvaU17oGzNppcOHFfSQCuJD0PWjQN6EjaocouVeX3NSCCXNPQvHk/Y8DB9NawflqyI2bzbQBx1RJx8fu6D41s6IfvUGaECj4K9voBk0SWZ3O4iy3t5Yqs3iE2Go/oXmj5tAk8H1JiUsHYp07bCN0+yIdk1wP4qLnbj4yNn7J7i9bQXWe8JZXR/ZyjQ8wVFtNFRJ6xh8jAbh7NepQwuIOGC1GYYog54dYhWUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742403003; c=relaxed/relaxed;
	bh=ynDxjrYa7FoAeUzjxX8ebcosN+KRAaBz3z6tbCcoZ00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c8j8m1f6YV615hQSl6CUW8xkti3YCvzxDf7CNALax7ZBeHpQ+mC5ejWNk/GPUtY7PQ/4lQfXuCRj1nkW5yeLOmn06TxNyEFaR3oSoIcg5kVLkJlVxRxFSXtSdWANlQAS2ME8IfX+5vSctPLM+WiMVpZhfFgQGTPwpifb8xSVbKnh+pPTzltLmBASW8XBoBaqURNDXryz/4gLWBTus+3jIBfTit6Mr2IUHtE51nUUft+FBCGXurdZyEzdOqB+ttJhjgsaRq/cC97/PuXG7mAlf/pfv09+EjMx3OOthV1muy2qFJIMcU8PK8C48cPUvmMZGipyccQOI6bu9DgQOtJT+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Rm7hJDJ1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Rm7hJDJ1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHvp32Y3Vz2xGw
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Mar 2025 03:50:03 +1100 (AEDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so2210725a91.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Mar 2025 09:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742403001; x=1743007801; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ynDxjrYa7FoAeUzjxX8ebcosN+KRAaBz3z6tbCcoZ00=;
        b=Rm7hJDJ1sn03htZyG4ohESRTjlJQnDdgl+AsBbeKJjUWQaY0Y44D6MUy6XZx47XO7t
         G33s6nZVbWYLvuaMyLp4aMbnRproZm0OOjvhL0Hlb8EsUabDH5uMxw7+xGtk+fBLJWsm
         eauEC7RedCCWAWX7sZpMVef+J7z9Pxgknzh0hxMABUovMcluMKdDUiyjOjgjjEgS9Nfx
         JMzXyYE97RzjFxFw9DXQ8HOVy02s1T83LPB1OrK1qMqHvGWhFcFUgSHgzA7dJOLwE1Cq
         GY5ACDZE3jHrsJgSUJI5OJx97O6D3bIkR9doyvV7s8ywWtZUNIfCqcQZLuwiWmbQMnhK
         6aTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742403001; x=1743007801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynDxjrYa7FoAeUzjxX8ebcosN+KRAaBz3z6tbCcoZ00=;
        b=epHINzYkNN+2BSxf22nzooNQUUfPh3U9us9ORk3lHhW8ZAOeWZk1gA30EN4FuGXXOc
         nlZE5zFHiZTZznO+Nj1+ZWXwKh6zzSekz+sZg7kSuOvqhxLySekCv/yOwH2ErQ2+Q70C
         r3tnpKB7Z6tJzrLawuIUySjnQdLeMo4Lfpsc7dyjXuvS/5I5kgkfruOBNGTRqtzic6sM
         FeavayO7II11uNRa1R1zSeagGdk7LhtzYasuLtZ2XbLSU6IG944TRJq2wdaG8r+qwXFp
         nJosYb1pKsUX7B3kX2mLWjSqHGwZB/mBcYDGqzX3SeLZENWcsBiD4h/5ynG1fMzkgr5A
         1Q2g==
X-Forwarded-Encrypted: i=1; AJvYcCVnRYdAlqWXv3Xs2S9lJmm/Udb0V8nBZHYi3iUlvmSJcOzG47tnrsTPpskPCoXfmmb4vnkAHu9r5CRqs+g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw0urd6kUmnCsDNizdlk5doDKvQB/VH86x0Cc98Rj6Tw27z5hol
	e3slcBH0vpmkCbUQhMGo2OXHBZjTzkcWkm02sTw05Igi+kywpTqN
X-Gm-Gg: ASbGncvrhzG6lX1cMDRi0GDh/29KJY8p1U8RAjhs68Bqzi11WhE9jYwKxjkWH7jf6Jk
	pywLvKT83ZrtMTshBavfjkSPOE/6JKY8VPt2dTstpASCo0p3ZP1VKVCPcv9NwjW1Dr0Xwf4YjuQ
	A7kvGmnDkr6WWdK/b3fvTp5BdxkNP8U3ZSzstsAqei0YPlKetlbQb7EVvKoSh78hHGu1MyjoHJt
	VDh8TNlo4bRwZAP4EPYfzEYzlsKBC5b2J9zJKcotG7YTRRsnk6Rx6XdV4KViYHfis0w377NAFdq
	T5OesRKiDJzzcHWlB9xe5/zF4hYYUqNJf9D7T2rEJdToNCOPjWvfOPM6nFDfVVRjHuEEfav6yRz
	1ONH3+BqMzBufTF+J8fXuFQ==
X-Google-Smtp-Source: AGHT+IEPzE9naIMttqXOLhoUWRFXUcJblI/+wc2t76fDOdhnGHN6yVS446XwCmDa/8Wd9X7f1CLOGQ==
X-Received: by 2002:a17:90a:d2cb:b0:2fa:42f3:e3e4 with SMTP id 98e67ed59e1d1-301d426aa83mr318882a91.3.1742403001305;
        Wed, 19 Mar 2025 09:50:01 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576bc2sm1863641a91.5.2025.03.19.09.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:50:00 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 00:47:25 +0800
Subject: [PATCH v4 4/8] ARM: dts: aspeed: catalina: Add fan controller
 support
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-potin-catalina-dts-update-20250102-v4-4-7c34b8139014@gmail.com>
References: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
In-Reply-To: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742402988; l=1019;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=t7ANTDBR075H8RBppIiRK9+hZDXy+IIalMi4npH/zVg=;
 b=DZjKoG8cTWZG6sPj/bGcrkU6N6K8GsHjDI6C31PtF0z67BiheTqcD5gV1mBny5NXifJpwOO9T
 sFU33e0hGu0C7S0SK2ayEIL1wcZ+3oY5Xc/XwUq5BOtwgsp4dM0E/tX
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add device tree nodes for the MAX31790 fan controllers on the Power
Distribution Board (PDB). These nodes enable fan speed control and
monitoring, improving thermal management and system reliability.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index db999408e397..0b513829f2de 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -526,6 +526,15 @@ i2c1mux0ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x2>;
+
+			pwm@21{
+				compatible = "maxim,max31790";
+				reg = <0x21>;
+			};
+			pwm@27{
+				compatible = "maxim,max31790";
+				reg = <0x27>;
+			};
 		};
 		i2c1mux0ch3: i2c@3 {
 			#address-cells = <1>;

-- 
2.31.1


