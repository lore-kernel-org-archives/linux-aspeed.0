Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900D260A261A
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Nov 2026 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mokcNpSC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPY6k1wt9z2yDD;
	Wed, 11 Nov 2026 17:10:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794377454;
	cv=none; b=RHEoTf5FH5IRgrS+3ecR6W+kBtOpgH7gOb+B80/S/yWXPhghF6lXKJiRWHMR61K46H2c9nBr6EDx6ONrx/mEpzZo10qRWssysepLGXdJUG1ROGHm7vzrmQ5MjRqQo9HKaL5Y+gIMiQclbdmV4LCToowS0ux5itU7sgIGGTgFcOLBCvR1/beOOnrvKo1PEzxYhbtm5LtgwM6U2q3RnwYP4m9efG/2Kyz4G0dct9lTjfLrps9lv7wWkWUXQ0CACJDIuwuy2Nrsu283GWdSGQK064Nj7GxbNr81ISZv4dw7kXerpofM1EIxEABz4NylES64iXLN3itSSKlULrP9p+Sbgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794377454; c=relaxed/relaxed;
	bh=tf9jlObbsd4CIoq6s2RKk4rWo7jBbta2pgzbHELu6Xk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OrmQpBfVDLPH/x60GL7vzaHVcFVQwOSCb6Ql0xlqovVYtGlK7TR5jLNs3UhCSAh3i0Vm/KyLhsgA4Qv6lb/N2m1B7kZkEP4Q8foHSdfuzUhyRB9ozbHxbCUTl20wVpKrpQg6SDDNePhI2Td70FSO6d8CBkTTo5bUt/GxB6rA5McNWdI+PWfqgxbE/2lPM3zEUXKZRp0vIJYzrJrnbw/qeXSH7hTSlmHz1aOZ5I6fWweEeGhJ36UG+uvIHBRiBIGN0Ug2mLuCxeHS5XIdEIqtKQ9ehiDU8H14elMk3Pze+kn8wL3tm80U7RezshkHIoyaKw0DsVaCBy2WRavSQwgMKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mokcNpSC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mokcNpSC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPY6j4tlcz2xGg
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Nov 2026 17:10:53 +1100 (AEDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2ed06b725fdso21145195ad.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Nov 2026 22:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794377451; x=1794982251; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tf9jlObbsd4CIoq6s2RKk4rWo7jBbta2pgzbHELu6Xk=;
        b=mokcNpSC3UIcGRvjYwfEKEeGDpUiMaCNTHOOeyyU6Br3QhZrKXPylQVI4bRcBcRpon
         jWPCmQ4nN3icBFR1RuChhyVQ8b8P3E8En1sB8QjofAlOR5cX16LqNcsMrCS3lZNwn4vJ
         3AOhBmTUiuInzk8mmCrxxy8pYrGtzRgCKPOkcs02Xn4vx++WDFI3mOY7lhJK7/3R0n18
         SRs+ZwAUJjQI8P13a5scMa3QZz10xt60ReHJi+tFHNILE06CUUv83ZmK9hzmhtSzvoVk
         PK+9/PpKhmcMQnoI+S0FO6QifTSPYtnQHNxvSMd0SSZwpoluEODyKD2UJ0663Zp4iuTF
         /bXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794377451; x=1794982251;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tf9jlObbsd4CIoq6s2RKk4rWo7jBbta2pgzbHELu6Xk=;
        b=T3vQsniCKa2Ex3KuSVT1QcrIXV57wx/bMEZB2vbsocQtGJGYsxl/G1zS/5w3NK33ZI
         v0RS1SulZvebG/mngitbOMR4/qgJSiorenXt2fufX3SoRcoNA4I8hDlO0r9eP9aGX3kg
         ukAAfPSm7kVXANfr5wO9nPbeHBAPoHpOOpJ3IiW8zbF5hqgfvGzYcodoa0/SdjaAVjnm
         3qaYOlCIGwoBagmHR9648+48L5WSNvo2MkJYrhzmD4IYIMJpNt8Bd+yCPzpS8Fbv0VBE
         LVj0jTHbYCNpIxpiowfthLmG0z5r15fnMTF5NwQqBY2A+mgHiWLQiEpNgp6m0o4+oZIq
         R0Ng==
X-Forwarded-Encrypted: i=1; AL+hErHLQ3YWlwWh319HcYAJx/x+YqMGjB3ElkAWunOHtRwCGCi6ymPf7yvnCDAk/u/9TFyDml2mcpVFd1P9OhY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+K9ZFa/0hETv5Q/BsPxd1pduJoc+xZUH+6nx788hPJ1XdPso8+
	6MMBqo00dEpnt5Kdgmb3R4KGStAVxv9HLSpEzLokJ4kLzTjHF6m41G0U
X-Gm-Gg: AYBFou33eFy+GVhLiwDPOF2+Vaz4Mjq8nhVQ2kkf5BOL9VZKAKZxw2Npa+qRZOeVhMY
	zPYunpedmazpUYHXVl33SGqhbGvLXzXKaAGDrR1LbjQB123hyxVVeSFjtfofBojUB5RbQe4/xtg
	DZvHylUvHPa02ZMSgVtCCu7v9pzTttS7X2uxzpkITH/bpLuFiVZS3+GR3EDdJ9GZGPfi0YQO5lQ
	5Aj/UemDy6vL1ekneB5CySdjqTPvturLk/ou9PcgpDSAi9KKjF0JWsTUw3RC58AbI201twJxOaL
	t5zrD0ONFiIfA4s1JKUosXVR91Mkwcz364Ag1R0fbl6rcrq5dq4+Aj5/JVj/4NxTqRA/jGIs8k9
	qCO5qNzjgPZ9OIIK+gyRh0I2TsI+uzEyirwCK7KjCujo4prHBqvK3XW74ZS1w0LYul1q9N9O6Ud
	qt4CCSQk3iB9qsMpYRFIkzjb35pX3jm2AQhllDL7YBWVlegq3iLSsRTetE0/01FefSOqjtk9Y7N
	+/nUybV8h4xm1O/D1f6ECpofp/O5AVdKcmARdHa0r+0FfytC0nnlVMtgkqtqJMqshLtMKuQ5s5F
	wRodEhMZT/W5ozySWK8dA4HAKq39oCg993vVBoTjqYZgwN29wHpZqnKBVVPxddS1FTEK
X-Received: by 2002:a17:90b:3e85:b0:3a8:786a:cfed with SMTP id 98e67ed59e1d1-3b182f91c63mr1169003a91.37.1794377451297;
        Tue, 10 Nov 2026 22:10:51 -0800 (PST)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db7e8b1sm2978557a91.12.2026.11.10.22.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:10:50 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Wed, 11 Nov 2026 14:14:44 +0800
Subject: [PATCH v2 3/5] ARM: dts: aspeed: ventura2: Name the COMe presence
 GPIO
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-ventura2-dts-update-v2-3-bce5b5dafc1f@gmail.com>
References: <20261111-ventura2-dts-update-v2-0-bce5b5dafc1f@gmail.com>
In-Reply-To: <20261111-ventura2-dts-update-v2-0-bce5b5dafc1f@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=JUNGHAUf0IQHmc6IEwFOoWoV3n/zRCC0p3wp8n0F++I=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBq9Af1293/fjBxZT8qUQ7Ck1LzVeXz+XG4VA8iq
 w/9bLeZK7aJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCavQH9QAKCRClg0K3CVbE
 gd/HCAC29OQHvHu3hEGDxLtfZftWnVo9wSObeWfAYbo8H0gxB9xNgPeWCZdlnrbWJaoQW8iLJeJ
 nPbdsyxL3kL2h5sYjLFrZnPBxHUwI+LfYDHG6DgjdoKan1x0CxAWR72tkxv0/IVQBNmPl6DQajn
 KKjvIhtdPdU881ZSuBaOyTGfRpRImiTZbyqsZxsiAxhZMFWIAn/H1qOgkwVwnMWwJSBGMeW8j6E
 J1ox//pkKu2LZFkjIBRIC+LvdPkEd6r/wWDSJz7gcync1njgf3+fn/IfKkjVahhjIYguBFTnmY/
 eCea8i+6hU5+CkSU+JgM7oINoUxLzE4XfqQxXTyYAWnErhL3
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Line 9 of the PCA9555 at address 0x23 on I2C bus 3 is the presence
detect of the optional COM Express module. Name it PRSNT_COME_N so
userspace can determine whether the module is present.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
index 21c40dd4bb84..c683ac19aba3 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
@@ -625,6 +625,17 @@ gpio@23 {
 		reg = <0x23>;
 		#gpio-cells = <2>;
 		gpio-controller;
+
+		gpio-line-names =
+			"", "",
+			"", "",
+			"", "",
+			"", "",
+			"", "PRSNT_COME_N",
+			"", "",
+			"", "",
+			"", "";
+
 		interrupt-parent = <&io_expander7>;
 		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
 	};

-- 
2.34.1


