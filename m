Return-Path: <linux-aspeed+bounces-4653-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB536C5AC82
	for <linux-aspeed@archiver.kernel.org>; Fri,  7 Aug 2026 08:37:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGcw261mpz3c1S;
	Fri, 07 Aug 2026 18:37:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786091842;
	cv=none; b=fQN0MduQKRJJsOYjyM3OF3Uv1R2aeITFT7a8ypztlg0m5hSw5DpgryARfUw6IZqqALCTRSiUm3zZ6l9+iWcsokA19b8lsiPVnItQRA3FF8drMTTPkjwZ4EJexBhnSKcvwDD9f2OkJ2qTXxrfDiefPSjjfp/SOmRzlF+GDQV6YiUGQ0udm1DB3p7GjApFnpa0OGZnYwBh98EjUscq3+DdB2r41JO4oaayAbXRnQMcmZkctHE8NNh+MVtfYD9A3L2BwP+F1wtoCKzMnf0rRZ5iDOQKDkm7Z7nLd5a+/0vb8xX26+Xc2nmMdRkr0AqYY/FuXDT8YtHPZZFuMGN0xnV7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786091842; c=relaxed/relaxed;
	bh=0Aa0XOZmSfIfd7MTfSKuapoTZ1eZa+JY5dctKtdAPzg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=mvTAlRl10GARwPnAn/cnO31EK4ciLt7+c8sU3wrWIMKsiwjymKRFPkIdOp0fQU5lcMr4/bMEaCoIvG3dMdOKZA27rhis4QE5TpyhATQRyUflC35rVADSH2jx7AE922kpV/Q6jqt0wK9AofKEEFBUVXhlnYPMXFDdtfC6vHF0e/eyG2XX9eNO3EKPfHhoSxq6y3Ji7AWgNosOzrTpAu/uMdN1wPmQbbxomjn1iglxECSiDv/Nc0ynpMUVaT7s+0fHQeL22lJwIfQ9HwqoGud09io/b1YWSKLitrZ1DCAHsBI6L5rX7gcYsL1uUrX+Ytjyj4G3N4tq7PMFov4pJQW3TA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=QELaiBIC; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=QELaiBIC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGcw16xgKz3c1w
	for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 18:37:21 +1000 (AEST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-493b966dd74so18843345e9.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 01:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1786091833; x=1786696633; darn=lists.ozlabs.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0Aa0XOZmSfIfd7MTfSKuapoTZ1eZa+JY5dctKtdAPzg=;
        b=QELaiBIC4DsUlQrfWQmWoyLGZmTRtIXUvXGYE1FXQ+00rSI+gN94ogzlt0J6hgclKZ
         8snB+aPuk+QRRAEM0eStjnZnhaq3EHZO1qspQcMFWaHHh6rjj/Oylp/VQZkRueqrA1/t
         Z89mdt/ApRZU2bkzh1sgI016T5Idk+mbOrNQBNWpvymlyv6QVoU2hAN9Fy+hT6N7pKQz
         KvbCRV0E+LYQyIkt/O0n52ZnCpp7LqISkosN1WhfZr5f2L1xg7/BXsan1d5uQ70xo2Mv
         /sS8wJSn/xdOU7vKtmyCbR7BdOznSgc8alDgMbsTxBOh43FLsaupbn4wiHa5J4iMkdBx
         ftpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091833; x=1786696633;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Aa0XOZmSfIfd7MTfSKuapoTZ1eZa+JY5dctKtdAPzg=;
        b=pfbuGkjCM6WE5hp+i+gPfZlccAz2HjrDfEdCw1c1TU2nMzx2hHZana/uAx54tdPg8F
         m7WXI2HfU1vcO/83Y31Piv/xqFOUAgvEByvfFsTqPzesnd5SIjyDA1rZhNz83eKr2tfW
         mrNbx5xfH3+HTLTznNwZPNw2RGRRImGrFIYZ2yKAJGZpCfVhOkib46oDoPWIkj4gltPC
         FB/McHNzhrCQSqD6/Rz0WHPw9+oF2TdKbhCSl9AsFUzYGxV5DZxFIfBCRKe6FQBu3zrH
         BOY3am/8U9FiI8abfiwHKJMNg6/WmiSDtIEnDUsYHvV3TZVpR7nky3Vtw0m+YsvkXLEd
         zhHA==
X-Forwarded-Encrypted: i=1; AHgh+RrTZhip5vT3AnBK0UosoM8Djz6mXQGhod0ppF7lASlaSxvcvBvnfdTd/1hntdnO7pvcMKfYXw1oIoGIfDk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyeGPqMOPYVmyVPQBTyBkyH2nV4dC9ZGp4ZfS2vvE1u4bSpAXnE
	7PTUeZ5ONc2aYjKqxq9HhS+e0y5Fqy0T31v0A3MMbHn4lJTOKQFuxWYWJE9pejxnt1w=
X-Gm-Gg: AR+sD12UkVPZaUO+NRCUwt3OpKIx/szaHgldKwOGAzSu48dZuKSfb0efPt77Fy2U4D/
	FSaPeuQ94gYDH3Sm8dxqNfaczf4do5pp4adsQL2yATnjoB6I+0DhxWOMeTFjTgbxw1avB8lpS32
	b1vJhfo7+Fxfy/f3Usha2xHaKlgQvDst+0H3YEvDMiuhHhBlA/z11P+Wx0xpToj69+lVrerJE4Q
	RQcIVp+z6aQoMnHMt5D1PgTlYvTgLCd/pQbuYR4J1rYnP6LfwgDAKnhS1cbRigksLrEXXw4t9z3
	jHHvtIO6s1Ysoht5J6izMHPym3DLDlaOKvgF32cRB1UeDATU+P2J2L8Jy1tUSB4a4uBXU913nf3
	Z9phGI4YzJFe70/VfCVTBK3kZjTBgmunLOpyCRsFVQSCDJfQeWpxA9JyIA2oH/k3Im/XnkxrpE9
	LRW0Jvh+7i4JsZmnTGaAWUXLpI9OUitGxi7mT7ycAHBI9pOF4t5zkV2JkmJEGGCC4P1gwtHCE=
X-Received: by 2002:a05:600c:19cd:b0:498:28b:1045 with SMTP id 5b1f17b1804b1-4994e793f63mr257933615e9.3.1786091833285;
        Fri, 07 Aug 2026 01:37:13 -0700 (PDT)
Received: from [172.20.10.3] ([2a01:599:843:2744:7f5d:3df0:76c1:3705])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995e9e7171sm17795195e9.1.2026.08.07.01.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:37:13 -0700 (PDT)
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
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 2/6] serial: 8250_aspeed_vuart: add
 aspeed,ast2600-vuart compatible string
From: Tan Siewert <tan.siewert@9elements.com>
To: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org, 
 jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, lee@kernel.org, andrew@lunn.ch, 
 jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
 anirudhsriniv@gmail.com, tan.siewert@9elements.com, 
 linux-serial@vger.kernel.org, mfd@lists.linux.dev, 
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <56aa0a5e26ea76e4f9a27ed059d2b05bec9cffa5.1785932211.git.gregoire.layet@9elements.com>
References: <cover.1785932211.git.gregoire.layet@9elements.com>
 <56aa0a5e26ea76e4f9a27ed059d2b05bec9cffa5.1785932211.git.gregoire.layet@9elements.com>
Date: Fri, 07 Aug 2026 10:37:09 +0200
Message-Id: <178609182922.193353.8621406142541186098.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786091831; l=299;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=GGZJlZzLfev4HdzTInv04JY3/Vaa6A3FvI60xmArBaQ=;
 b=HyICfGSOOmuh66kJTlxZqHYzoimh8x1WZTAAHnZ2sbtvqD6Bz0e7JwNlt5sEHOPp9XSolfUBZ
 4LtUL1zC+S6AO+F0anHYOAXIWc3YKWwmxlWPBV3bzebGcSeZmzvR0I6
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

On Wed, 05 Aug 2026 14:19:49 +0200, Grégoire Layet <gregoire.layet@9elements.com> wrote:
> Make the driver compatible with the ast2600-vuart.
> Enable specific configuration for the AST2600.

Reviewed-by: Tan Siewert <tan.siewert@9elements.com>

-- 
Tan Siewert <tan.siewert@9elements.com>

