Return-Path: <linux-aspeed+bounces-4757-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117ABC5DF81
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Aug 2026 14:02:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQ7Z708wLz2yT0;
	Thu, 20 Aug 2026 00:02:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787148174;
	cv=none; b=U0hZyPoYhlGiT+bRY/p6NypLGT7WbGFvtzU9w2xoN5kJGlzmZYRB+WJgC0ZrJbROLOXosFrK4D9Ig+42b3Tl6XvXBjyIxd47XSRBY5eiajLpxX3m0qCDUhU17Hq2WiDbBYnxOmmPgmGu9nBwKTYm1UaVW+bt9bxYQGw73X12r/T5JptgGkRQImqxJwdSUKC/keDhBVi3KajRaNd1u03wJPp2s9f3XuqQCQphTNR5RbtYyyttd8MicFbCMPquQkc3zdPWSEfOfd5I4294PxCbXKLQ86n+4PSMdr0RAhSi5h8fBSehzqp9NK2VgXVe2YNy7XEXDWPtc7Jkj7DUr16qYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787148174; c=relaxed/relaxed;
	bh=6HUNEom2bL9x12H58ozzx5ab5h2GR4Ct4g1sEt5gJ2k=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=OyjFuJNq5XCYEdQ/zGPwiuTF7wynQXYdWpbZWZqg83cyFf39cC2k1kc/YxDGTTPUiY59QScipnTWIGhVH7Mukf3J8R5hmffvFFJUdmhvmfBOUWWmEPFruygU84V+d08AuDjALcX6IeUwb0DQsRgLxjuRGhQOHenMCM/V5CQEprVgeeHpCMPpshLc20nZU0CPgQYF50Fox9lg9scoKIjplPm3vkFI+aJi2xdD96bXZbLajnnrFA9dAKK0+w30n6/B2mltA5HDllz99+OMSfKVt+g4SOBmW++kJnlXymIpQJBbqPM4xTyNvMJ+HE4YzwFMChOjKJJLA+pW2cRAyqtYmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=a5ljcvIx; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=a5ljcvIx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQ7Z50662z2yDr
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Aug 2026 00:02:51 +1000 (AEST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-471eeac43bfso827228f8f.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Aug 2026 07:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1787148168; x=1787752968; darn=lists.ozlabs.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6HUNEom2bL9x12H58ozzx5ab5h2GR4Ct4g1sEt5gJ2k=;
        b=a5ljcvIxrRHZdaGRF/NZZmZTiwguprnywmtuhVMSTlbJ372ct/iO1c3hOj7hkdRw2y
         EE+pLeC8GhOOPCVIT2MCRSGPFgYfPmV7/Yut2pqD/RR/RFgs2y/AQ/4bSsgqBXcZPyV2
         yFioOi1hbCX0wkHww3XQ+onvXiB5lSfToXm8lUGYkhsyH+w6XxJ3vL35bzDuBIcbSggg
         NE0lvn+plV+Dpc0mHApDXyHV4W0Ivpl/WJfrExhtfXOiELr+LVfQX3I/xnKRLztcoEyx
         Rwp5U6/wiyy9lIvZNN0d/05oxp7b/VOsc6ywDyyamizZnYiCuzn09Q805LT3AjBWgB5Z
         M2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787148168; x=1787752968;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6HUNEom2bL9x12H58ozzx5ab5h2GR4Ct4g1sEt5gJ2k=;
        b=VQ0Dps0M9d2iemOLQ1wAszd5McZ2Mx8BHGZBv/jraXylezCjcxAYxNEtiz/3O36vhA
         GbMW7NhLS3rCw/139WrtBBvBihLWomGrKeGhufQHbo3WVyYyNu+knPa31b9sf3sa6z0h
         fI5RFz/TyaC/EWz/mU1qPoSD6q2ARmv/OgRHfAZ/5RdJvo4khNaWaNeEa550TxjF2BXF
         1Y/3WKEP6GQ/+6g3qHZLcUyLOHrFgSolLucOfbqEEqftpv6Oj4eaNlS1fdcwkdxl4EIW
         yHpmHD+sYSQfBO2kFuLhggw3TZaNZyVKjZlfGJmTCBMbM7Ok38UT6wps8RczSye2Su3F
         EmmA==
X-Forwarded-Encrypted: i=1; AHgh+RoYDoyD9jni1rCDb+XHemdwU1m52Bo5HWqJaiOVjI3/Yc5SE6h7Q33gBiv2GasazPHXLKJb772wv2xbDG4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwGFeVdNAnaKlNr2HrfYlnms4e89sv+MOY+sGzhMOERlbVhG3Sl
	mJrjrbdgHgQBXAs64OAxFNE2RlYC1pcwo5QR1BNQ/JxMaSbN99tI3GEPUB3ilBihygo=
X-Gm-Gg: AR+sD11xLL6Z6dllUh8JNtyyESer13PbRREMegAg5Zi1uyZUIuUsmIKaPLvDBhNm2ob
	zq8cBXF8Wqjewe8OMkpk/VM0U10JndmtNt+JhXmyzLyYg6D6cxql2OxsQ5P6u9hj3Pag2kjtQoz
	BjgnAWy44m01OuHomdozw5ufGwg3xv9++uq9l3V9U0WVz0ojGg1TwJdJbhP3cx3fuEL2crXrDd9
	DwwtCqHnhvy6B5ploTWnw15FW/4bdUAmAibm35lh6yq/blNGj95tXzFNPcdXsJItv96M1s+Zsww
	F8ZAX7oqOR9d6J5zsUtYRr6YY3mtTyLZgyAfMLb83CwXl7o+MbuYADV5MFndPRXFSfRyjVgMjcN
	fXNrgccO5TWGw34K+roRRzcSjNuVHz4q9yMcyA+KvVjYaPjzWN3WKpRQmI2+KZ4SV6N+NpKE/bt
	n1rmfWqdeOsJQoejYdSHorpEw9VeBNfv6n/843b2XQ8OVggLxLOOTO6czjnPT1L02YV/C98PUvE
	nKOEnY=
X-Received: by 2002:a05:600c:4eca:b0:496:c1f3:e8f8 with SMTP id 5b1f17b1804b1-499aa1a7a53mr77553585e9.7.1787148167637;
        Wed, 19 Aug 2026 07:02:47 -0700 (PDT)
Received: from [10.0.5.39] ([2a01:599:445:d261:4474:9672:b73d:5481])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa1111a7sm65896975e9.6.2026.08.19.07.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 07:02:47 -0700 (PDT)
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
Subject: Re: [PATCH v6 6/6] ARM: dts: aspeed: g6: add aspeed,vuart-over-pci
 prop to vuart3 and 4
From: Tan Siewert <tan.siewert@9elements.com>
To: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <git@gregoirelayet.com>, 
 Tan Siewert <tan.siewert@9elements.com>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, mfd@lists.linux.dev, andrew@lunn.ch, 
 jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
 anirudhsriniv@gmail.com
In-Reply-To: <20260818-aspeed-driver-v6-v6-6-fd7cc0b338ea@9elements.com>
References: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
 <20260818-aspeed-driver-v6-v6-6-fd7cc0b338ea@9elements.com>
Date: Wed, 19 Aug 2026 16:02:33 +0200
Message-Id: <178714815309.32179.8598674853319251320.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787148161; l=396;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=dlXJOH7EU0a51dAApmdxSA9IP84RNY0Lan2Iu+swRps=;
 b=c/KerOBtBLlU7G268kqzunbiL/W9hE013JTk3ATgEU/VaHaT/LXB+PpH0Ob3QlfkpPx+mFF/z
 EYquBWAhiQTBMj721ke3wRMepR8gy9yQ4WznJiFfSG2PvjnXP2qnlLi
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

Hi,

On 8/18/26 12:29 PM, Grégoire Layet wrote:
> The VUART 3 and 4 are VUART over PCI.
> Set this flag to indicate this information.
> Also set the scu-syscon phandle.
> 
> Added lines are compliant with dt-style strict mode

nit: no need to add this explanation about dt-style strict mode.

Other than that, changes are fine.

Tan

-- 
Tan Siewert <tan.siewert@9elements.com>

