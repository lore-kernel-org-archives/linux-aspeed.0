Return-Path: <linux-aspeed+bounces-4760-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B5AC5B572
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Aug 2026 20:50:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQJc34VBTz2yRP;
	Thu, 20 Aug 2026 06:50:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787172611;
	cv=none; b=baghKoElstIG1qzBZ/A1xBIdECaaJzgnu7lQCH8D6NN+/rh07KTSou5yvUTElF3tEQNcHpNMlRJ6IxJSCbT0x4jCYMZoSkor26Te7rKhwAYgC0qMs6KcvqMOoBPJBqpQp5dlSI+O4lII9AwBTJaiyTSssbA36lapcMNhb5I0eUgpLsoF/LlrjN2fT18gooBCQXaEgEO2jmM7u4WDcQnBHi+o01sgmwXshnnjJPqT5stuG6vYhVcXb3wiitO0UMLIvWlfsJDpou38SGITAaMtynpbWxtjU4gJk60+KOtdjerw/DCfDE0lwO26OnNI9a0xyLnXNVbPgmyPQ/n95AuteA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787172611; c=relaxed/relaxed;
	bh=D8ek9XEABkKYopYQPGgQ0eZy+De8ylYFeVMzcY2nL9Q=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Ln6ow4XQv+DWCXhD98Y9FpBZb46BpBlKh+hge3/Nfm66K4sOroitDXOhUwpl4kjComxl1hq3XEFPF0XsryA7JINsqTaYrC2I9P2EJlZ8vmz48k5psRUOe0k34kMaoaWx0tNkJqNo0bkij2Ycb4vPq7jqLweNQzUr7eIXm6dRGDs9RBKtCONP9xcCjFfDXb578AsxOMgvcRoz9cRTGlcdfpFkVJPoXzgdrFis7+u/JiA+X5u4j13l0Z6ciRssrZccYIEBoULQtFoj66MejmeERFk8MJX+oThK7pJ8AO0tbM+EJtVncH37ykssAn4ojnARuqDSoEloXvBqukHEriHISQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=ZIYDtlF5; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=ZIYDtlF5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQJc11xRWz2yLH
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Aug 2026 06:50:07 +1000 (AEST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-4813ea321cdso192464f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Aug 2026 13:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1787172602; x=1787777402; darn=lists.ozlabs.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D8ek9XEABkKYopYQPGgQ0eZy+De8ylYFeVMzcY2nL9Q=;
        b=ZIYDtlF5bxyGFT1K7hQJ8k9x1CaBvRJuA0R1Qz5hU7fEacL+8675yEIrcV5RTpdkE8
         6/5+DdyIdeuHFpAREhHT/T6ACD4FGFyL0g6PY64B8KSeWMwmQw5Bdo+TgjYMYaf8pbYi
         4FrPPCeumxTPFo+qMvZtoaNDNeeUmDOSKh4SyGsa5W1EBXsHQjc6O7pKKcW8G9bnS72X
         aGj6rNnxTgtkzjh3rX1jV4idY8NHD6aTcfDaiTqa6JAz3Vss1SPDloBXmQuda2OshD+c
         vwVoy0d7YutktD4GSQDQouyAumyAYjNU0e2QQZTxh7skr4deGGlVzJ7Hgq01JEC0gUQN
         rAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787172602; x=1787777402;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D8ek9XEABkKYopYQPGgQ0eZy+De8ylYFeVMzcY2nL9Q=;
        b=aLgXu2QnzUtuRW8wQv4/SdqsPZ+tp3axSNp/bFWnsvBOvOQ2EACi5lLz/R2XKNp79m
         5dX8gxW8FWkLcVxfOh6WJfcdqj/4TuHfbyUq5XBSJcN8nC5ZblWpf47Rk++879Ezp/YE
         5vOhMZbuy2YofRKu3lwMw4/b4PgrwJ0f2v1oj4e5ucqPntwPhfW1ZNZmNEixOV+ljsEB
         JT/0yfiCOAttUbpfTVhVaroTQPpwunfl5jSE608SeMHKxdPa8FcvzFQ5AcGxlBLuyUaD
         KEBYR8Q8zDLdXdhLszj0qVP54Ro8UybPPA/PQhF6Fa1BvQCBSzQYA/f4gxFrayarg40L
         jwjw==
X-Forwarded-Encrypted: i=1; AHgh+RpUv3F2fXUSmz1agZV7wlM8Lh+Q89eap/yLwYbzsniqNQLaIe8wQC454YkMaMc/J57XRJLSWnpDM8UH90Y=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzQFdUJKw7xo/gnTrci2stO9cQPJxO1qAwEPCirFmWKEqegoqMY
	usnxOWl1J4FWrA6C3pVQKCxl7YzTcfMZUocXFbk+srj1AEqG9Hmh5RBixS9aDXlSiSs=
X-Gm-Gg: AR+sD1263+uoDDOmaEWLu0O7buPmAyLcp196xDrWhwetjziELIbHnZBZSw40huBrjaY
	/jWyTL2asANA9D71yEqS68/FKBHptNre+tFgAzvnxukCgqEcjyTPcLmL8+TvsQ1c9Ql7csRWory
	rAC58oWgjkLQo1phiP5rkf5TPQ7fnWMw7fXK+KmTWiv3cIBicOLclEoMUJCMFteWVBZI0Xlot6Z
	yw8piEvEieK+NYANgQqFqruwo/g3KYu4vGDcDWBDTKCXOd9BybIi0xK4frMd3u8pb4gApBnN3TP
	NgmaqXsWIB6DwoxMpfQefQhHun4S/Yhb2kq1iXDcZuiFJePP0R6OhRSuezJXNw+Iwx24/SMKLJN
	yl2kQ4oNB2iUr9tqYpjDuV48QEbjo530mVIOPuczqht86dxrAtEEJg2hvftF8Hwt37eJaB6ENUG
	Mw908OLJX67hynvnIIWnY1Hds4i+dJft4WbcfLCgPRpFA49LNxuvuozAOfV6Xtt0E1EOnBMZm8h
	I1Gh0JEKAKiAic0yARTVpO71fQmYLdFnaKCpJCPJReLUy8i6Vmqor/CfFUD
X-Received: by 2002:a05:600c:c4b8:b0:499:a5cb:b7c0 with SMTP id 5b1f17b1804b1-499b06adfa9mr26301385e9.3.1787172602473;
        Wed, 19 Aug 2026 13:50:02 -0700 (PDT)
Received: from [10.0.5.39] (p200300e66714e500bfe47b00fa11e276.dip0.t-ipconnect.de. [2003:e6:6714:e500:bfe4:7b00:fa11:e276])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499affa25acsm24257305e9.4.2026.08.19.13.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 13:50:02 -0700 (PDT)
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
Subject: Re: [PATCH v2] ARM: dts: aspeed: g6: Add missing uart nodes
From: Tan Siewert <tan.siewert@9elements.com>
To: Jammy Huang <jammy_huang@aspeedtech.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260723-upstream_g6_dts_uart-v2-1-4951ae6b4ac4@aspeedtech.com>
References: <20260723-upstream_g6_dts_uart-v2-1-4951ae6b4ac4@aspeedtech.com>
Date: Wed, 19 Aug 2026 22:49:50 +0200
Message-Id: <178717259080.130614.3272450084960702654.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787172600; l=223;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=Te+zNjde8ncPGxnQfN9Ew+2u2ctnkBeEiF85U5k4JHw=;
 b=/uLeucK5jyjnSISmeVUynHbHVwcXGwPgqKGeQfPtZ71BtnVLy1XFSks7yth89NtjvTduqB4Ha
 BtXB21dIBq9DGk/cuow/TXINuPbkdo4h8j30i0RkisjIO33+CQSveE8
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

On Thu, 23 Jul 2026 11:48:34 +0800, Jammy Huang <jammy_huang@aspeedtech.com> wrote:
> Add nodes for uart10/11/12/13.

Reviewed-by: Tan Siewert <tan.siewert@9elements.com>

-- 
Tan Siewert <tan.siewert@9elements.com>

