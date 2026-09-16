Return-Path: <linux-aspeed+bounces-5013-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C15C88E77
	for <linux-aspeed@archiver.kernel.org>; Wed, 16 Sep 2026 09:13:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlCqH360Cz2xbQ;
	Wed, 16 Sep 2026 19:13:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789550011;
	cv=none; b=YcHtvMMztIJIe1F6nqyC4TrUFV2L7KvBnDf7Hdc/A9nrPcggNn36jZv4Bxef0wGwXwLuK+bCud2en4L8ZtZxRN7r9nU33LpmbyP/QcYLPL80apFjRrYqrOwHucrYaS84tfWHpf7/eCCF2r5PUwFvYJWJTmj/seWrapJiJ0DgEPr9MhGJN5BsV1NPbhGcY/f6NyOoxkC4pbwDyf37Ez9YZ9/YFBcilGNjgQNitu8jXgx+BgQWHu28qF/AwNSOiZyIUjXT58BQTualSRPou0L0MP/+htVxaiQOMfUKWHHI8rzGc6XOBJTTUVCv9t6oEwNGu8Lo5NDXSUPLaeLLxKYxqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789550011; c=relaxed/relaxed;
	bh=2pxFKi7xaeFBiwVmmMG7qzY7jC7mdLidUrnKaVS0TrY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=I/vuXZtw8FcrEqS3ySBzVOe2xyTThjOAaolVG3RqGvCTiOw26eA4tDdhNCgi5NiR6pSh9B/4plor2eVGNze77Nwl31/a6nzT/sJzMCEmIOSJ2+QqpvgRAcflA9V3hh0num4pQeDpWdBVFQ2pc2rcNYMMvwJw+6L/H/+bcT2WZhTmE5PHuQ6xatRBRDa7PrmjRZlP/ehlop8Bg469afpLfs4seeZui5m6EcDjTrO/oExRTuvysFzdlxJNKrQbI7eMi7ICTQeiJZDWwJfYo6W8RewDtn2p9loXUt4EmTVDv/aaP7Dkx+Hfd/xxN2y7BgbnDnBhfvwLuFUzyCBwi0548w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=NTimDAHR; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=NTimDAHR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com [IPv6:2a00:1450:4864:33::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlCqF3Xntz2y2W
	for <linux-aspeed@lists.ozlabs.org>; Wed, 16 Sep 2026 19:13:28 +1000 (AEST)
Received: by mail-ed2-x10.google.com with SMTP id 4fb4d7f45d1cf-6a99c5de614so946001a12.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 16 Sep 2026 02:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1789550004; x=1790154804; darn=lists.ozlabs.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2pxFKi7xaeFBiwVmmMG7qzY7jC7mdLidUrnKaVS0TrY=;
        b=NTimDAHROp+9PQQKmzvJjtjL0EPlQC+DRlTbwNyWG8uieEXndB+fG8zdYu7haPD/Pt
         oQQfA93ZXweTDCziMVyHOMUYZdjgMhTCK5fDbaVqZSjv5cAhdl6W20ZitTDGm5Mvrc4d
         4TFDHT8r1800mseVL2Y2Is5OvSeCdbeq6Sg9eywR9hHzVLISZ4UiVNghj29J/RQxKEPS
         r38Z0uTK4VGdK72JT7qZf8nu7VfQvueZEx5a3jCFoCRy981v5eZ+P9WSuwKUbE5IuCe8
         z/ewQUsiTDH7XUtuBII3NEYLHqMuHjD5EeTk8nzuu57wBchgDQa4fB2SoEkqS6UF+Fzr
         uniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789550004; x=1790154804;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2pxFKi7xaeFBiwVmmMG7qzY7jC7mdLidUrnKaVS0TrY=;
        b=0O7yzxVr0kz+NOmK29Ro0440NyC1mE9axbA3z2QKcpF68FV13emWKFrYf1ZKXHFypH
         h+o7lQ64H8bTJPLaWFs4+TahkKdwwcFVFs6qh0gkwpYt2EztzHY3qC5xb0x6louW1KMa
         z4VtHY0axabbW668giXrKbXya8SCb+IcJrsGZPV5jaY8SxHUoOqZ6f3maDworM+1lxrY
         tVYIbJr5P7uffwwBxEtY+XqT+1Ox0EOlGszshda0I1csRfTRp98+eJgEuBSYyZDglXa1
         bUpFEpitIPisi/jaNbsbGIuF21jfr+zH9fJ29T45E2dioQeo11By5ph49QO9p7mqSFxr
         2tEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwPVHHkXH9UoVFcx6yLiTl/Z09tbnyKFM1THT1Y4JcJ5trKs8qlVhG+hFOlsvTgnH5vrTU4vnlzBN6l/EY=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lnhlbmA978BcBY4BwLEy1y1IxOWzLCIlcrA4dnBImKhF0UTKKX
	EYe+c4pL75QoxAb15AQaMpkbUa6BbIcoH1tDJRql0aJOKgaTFx4yIvRb37Sf+PnSsRA=
X-Gm-Gg: AYBFou33GNgcN5py+AGXfk9xm7Sb6TRoJdSfs410JnJn8q0evO0jaHyubqk3Qy+G88T
	85Liy95JApK2prnYvi7Y09ylJQ9+/5/MtiLaee/25zlrriPOzW9BpYGzcmCTCAd5nqRmPZu7NRr
	vdFtCwtY1XXvgHQHpdagrzyNjAu4wtc8OiKXfUaqtF1A9Fa7d8zqq/j86xT5Jb+Aitekuh8XxRT
	9cxc5icLufi4J24Y8HDFFbTl+hwewi0+lhkDBzEapJ6tKs4VpBukc6g26fLkhpSjX5GN2ugprmJ
	ym4YTUq3y81iPsSlS4xehSmLi8PiGxMN7lRMIdb7uiRhsC0gZq5y9d8Z98wopnDn6bRXjVtj6jy
	J/3FwAhyq//Co7VHM6RMQB3xGIV2g/fFZ6Cx2LTUuE6Nm2f4T2JCfRfqornkbTsRuOuOrIyq8j+
	qgbMAyyV8lDlfcIF1RzeIW6ORywh2buY81bFwWHq7lE4uOCycmS9voD2oocHCYjrfyDnTZHMc2n
	4Sxqz+hO8tgyCBs
X-Received: by 2002:a05:6402:46c8:b0:6a7:f25d:b59e with SMTP id 4fb4d7f45d1cf-6aa2241eb47mr2356354a12.18.1789550004367;
        Wed, 16 Sep 2026 02:13:24 -0700 (PDT)
Received: from white-mocha.local ([195.169.148.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1d2a874esm1148454a12.29.2026.09.16.02.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 02:13:24 -0700 (PDT)
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
Subject: Re: [PATCH v5 0/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
From: Tan Siewert <tan.siewert@9elements.com>
To: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260915013110.4780-1-prasanth.padarthi10@gmail.com>
References: <20260830182036.284736-1-prasanth.padarthi10@gmail.com>
 <20260915013110.4780-1-prasanth.padarthi10@gmail.com>
Date: Wed, 16 Sep 2026 11:13:14 +0200
Message-Id: <178954999458.14468.16283512434120694140.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789549994; l=811;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=eS2AzTpmwl/LU2/GTCNcYSrf1v77Kr4VQXRZMQWSnOg=;
 b=Kigj35XJyk3oqfYrmSrVTzDtZozWXiL3A2jZ1GDFn47XUDoi1sADnSqsFWAfD5moYuTYt2g/1
 YmIW7BejVRPDZg8+rwZ2qOhCgmhCmtFAgIIt7xSS0+t7SJFtsr9bmbA
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

> Add device tree support for the ASRock Rack B650D4U BMC, which is
> based on the ASPEED AST2600 SoC.
> 
> The series adds the board compatible and describes the BMC memory,
> SPI NOR flash layout, UART console, GPIO line names, graphics
> reserved memory, I2C EEPROM, and MAC0 connected to an RTL8211F
> Ethernet PHY.
> 
> MAC0 uses the EEPROM on I2C7 as the NVMEM provider for its MAC
> address and is configured to use the RTL8211F in RGMII-ID mode.
> 

Your threading seems to be broken (`In-reply-to` + `References` are set to the
previous version). Please keep that in mind for the next revision. See [0] for
more information.

[0] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#explicit-in-reply-to-headers

Tan

-- 
Tan Siewert <tan.siewert@9elements.com>

