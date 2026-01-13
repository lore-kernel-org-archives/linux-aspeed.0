Return-Path: <linux-aspeed+bounces-3304-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871F0D29DCD
	for <linux-aspeed@archiver.kernel.org>; Tue, 13 Jan 2026 05:46:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqysd61zCz2yCL;
	Tue, 13 Jan 2026 16:46:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768273151;
	cv=none; b=fCi8QPfjxeNt/C24egyJuDb8tQwSoc0KJr3Xpb6kB4rGKyetymYDirftbPiuc/2xh3HfeLB/Wd0HdtN4y7XtRZE2dEwSufMma/DdmndmVcJ81C7PVpP5pJlMqJVlMFJMm39NOSEW2wjGHRHCuczKqcDruyj7WGx4SILR6aDZNCBbWczQqyKy+lPXaly2KT4I+N5sQz2pl8o6FHlkNphSTs6wW8e9bXZsJj0salcba01stYjyFxZjJjXP+eky6Mv347ORj6eN7lyTKT1t/AsuFerAh01wqNy1U5jm06j7rlInuXsXa+x+Fkpnw7XSzJ00Y4HTvZu3aBwJvGU6N+YZDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768273151; c=relaxed/relaxed;
	bh=GHQDWCh+NRgqnWxAXwGi0xidd1PaBziYcGzk9y7BoLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DSVCXHPyBDql+M6UUOufJd5dgmJ0ILGBHp61p6JEi/10hFFRkR+SFAMSUiAe9N3/16u1rScZiMXiB1izHQ801oW13DNyW/ogmMAdFj8Yse4E3dinLWM5kuxVQ2ZsxzWBthsla4Px42YeQdqdE2v8Ew6jDi0vbxhiy8Z2NPHuR1vQNwvHpbZqPJ8cEE8kAYhZ9OD7huBmblwTbGLMi/MBSQcmTOoO4LuWkAV0Qsfw3zmKh4ZNthpJo85r/Y9XOZQWU4Jzr7nZTqJW36ggw0ysF+MuS5/HCcotBICgEdm8yYOKSyCfm/f6J//vjveEMrcVd/0mi1PfV1pCur1IrpnEPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bviZ9jji; dkim-atps=neutral; spf=pass (client-ip=209.85.210.170; helo=mail-pf1-f170.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bviZ9jji;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.210.170; helo=mail-pf1-f170.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqv8v0rcCz2xKx
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 Jan 2026 13:59:10 +1100 (AEDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-81e98a1f55eso1686154b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 12 Jan 2026 18:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768273089; x=1768877889; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHQDWCh+NRgqnWxAXwGi0xidd1PaBziYcGzk9y7BoLw=;
        b=bviZ9jjiiMbXSnuzmyHF3KN1dAergKF3ZSV/ZWRAEhLyPMArVffhbIYWBeYwM9V1kk
         Slq0Usr8VNR1Ga/QdNSlq2WBfi5bUAlb6lMIdwhUgqD3BOsvcExLmEBwnBnqlOWIzGrL
         oGHRqeC291X0GGZXhlcx1gNsZxF82p+b1RwVIHNnXbskPJTIME4fxO8ljfsJo8a9M8S5
         axet5wzrQ3aW6VsgMGR1souYqM6+MxAvHzu5L3DGfa0sHXur6II9oOK3d2Z3FMw/yJdF
         +3VMb/GdDP+iuNUJZNQYY7+SET70EvmXamhrihKWgMweCrwu3VhQTVbfpLZ4qSi21yEN
         nmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768273089; x=1768877889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GHQDWCh+NRgqnWxAXwGi0xidd1PaBziYcGzk9y7BoLw=;
        b=mXT8RxYQiM+RJ4zE1UzDCMZI/iQFyPv8WhdLB4051oNSi594nnvrgvQSCaPfLVFWNW
         bwLP7E8fgW5KTgDSTsWtzln7+W4YIV0rrasV3Ja3wCn8vvBmebJoYoHCtXSYBkdeIEYc
         7ovqByrTOPjbPMC9s5fGSUL069f9KTE8QMjDxdWZXPuwJkvCPKJC5LmJCv30/fkf2vN/
         ffZAjsH/qUUiRiq5lPRGs4KAZ4ShFHsmILWtyxlspG+vcnk4m2YzxtMenwXpsdVDE/Ki
         V2oKTphjbfICMyF101yff8DBCbOh8A3e7AifcArNNdVR9vyWCIrBoaD7LDI00ZkOcE9Q
         0dYg==
X-Forwarded-Encrypted: i=1; AJvYcCUY12zVux9TrhuljvRMm6ndwkroMnfunSojW+EATpFh1b9Qvg1WFWN060yXT9EdfMotGGfV4uIXXYwtlvU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxhwmnEvGHxT8rWP5X8FPd4oZsqAig4HmU34uNMFnnt0sVym44q
	129jhXUsN9Ap51gsqTef8+sur+nkDgJBkZtHKlv//XIcaLvL57PhdJvC
X-Gm-Gg: AY/fxX43epLgO+n3UvuvIiQW3///ARnBcctZcH2BABgT1pyJtd1sv5y3OkBSnoyOqJf
	IfhfuWlRYv+0Itx4QPdI+vCbRk3+Hit9GSBZqNwgY1MpcN4H4GLBxyWv4eoh9lGc54XMg4OOSc7
	dEUXaD2cQCFwJ8t2lzaW+sjLYAq1L6PXMNVqvRik9X4M54pFM5cronEGGle/kNG5V5BNWfs5fbI
	QqPongAYzCpDIme8W3U+01tK1InM2kHEt9m1aHq1NScIWVqDX9kjenPdYina1+IUg/1/0EGHuIK
	9q1ijZDuBgSXw2BNeLe6lONw9stMi+vMeD4pO64dn+qc/D7rMTx1DH/XjElEKDhg6PhymU/uMBQ
	TK+gHvpYireQe0gwUZIjZ2V2sLSh8lTso4h1fE/805a2yF/7k1DRafFpaFIgswRbTdSSXRVoFy0
	AESwLQhT4wHjkhPzWTakjEbuQBn5EHgsPz6PAUtwwzLzR2ANr0d4sYogmnqUnNZA==
X-Google-Smtp-Source: AGHT+IFbfsiwk3WMmRA98lrcTj05l0HYZLZt4FJsgOL46xAEGL9tHmyDVUsE6JBArvoMUM//+uW2Yg==
X-Received: by 2002:a05:6a00:6c87:b0:81f:4a06:6f5 with SMTP id d2e1a72fcca58-81f4a064368mr5838699b3a.4.1768273089128;
        Mon, 12 Jan 2026 18:58:09 -0800 (PST)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c530133csm18702724b3a.31.2026.01.12.18.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 18:58:08 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Tue, 13 Jan 2026 10:57:58 +0800
Subject: [PATCH v3 1/2] dt-bindings: arm: aspeed: add Meta ventura2 board
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
Message-Id: <20260113-ventura2_initial_dts-v3-1-2dbfda6a5b47@gmail.com>
References: <20260113-ventura2_initial_dts-v3-0-2dbfda6a5b47@gmail.com>
In-Reply-To: <20260113-ventura2_initial_dts-v3-0-2dbfda6a5b47@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=839;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=VIUy/ojlhS11xqGBbDRHLcMgrMJfETQ5L8/p2m/YihI=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBpZbS8dfk3NFCNHd6m+XrVE5Wa9rvTmzC8B2ZPs
 /sYTNpUCQ+JATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaWW0vAAKCRClg0K3CVbE
 gZQuB/42UkYp21m/7ZZCMwoYuNYMF+tzuCHT+265cU9fnLv6RMB1XvbuPOv2WTMC/Pfl9F6/i78
 fYlkW4IXiHMe4ubSl8p3n17P9pihudh8gKaOkI+sA7CWDHJ+1PVpUC6ybbVkBEYqdlBpZ9unCcl
 WXHm019M8JhxDLUw5791HC76BVGDtowDeI0UqV0pzlseM8PcR1VCKY/eU3XAXViNMtFQFB39bV5
 Q+VVQbcYWeil9gw9IVq0tpoSSrP5fblFSo8w4ZGt1/EColvQUhAfeC8+cM7Sd3KoLH2jd+QqE/y
 Fdp3zBG1827Ptry5cijbloluw1R6kAwp95MLtoM5XR9retL/
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Document the new compatibles used on Facebook ventura2.

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


