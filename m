Return-Path: <linux-aspeed+bounces-4250-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC54ACD4F2C
	for <linux-aspeed@archiver.kernel.org>; Fri, 12 Jun 2026 07:51:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcBY342cPz2ykX;
	Fri, 12 Jun 2026 17:51:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::434" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781250204;
	cv=pass; b=b0HWGHkymm6SX4BaXHSgKYMelfIdvSd2nvWAWjQkFiLcvHK7Jy+iPdUbFJYVaV/WDSUhzP1ZUms50gz6bdE3O6RoPOMwwLmsPCVDdzMjTpPwuGaiwrxQU124/5TbL20kBxw0NTuj7o8i+/KmsRn7yonbmZL7hyi/SY62nlVRLQwTC6BgWQ5aRMr8btWHUrYGSL/93ODn8U8x+cfOCEzjlGYUPvYVV32ZNfnYaQfipFZW0l4fI4yxCTZwNo1Ob0msDyyiIEHwG3+7gWKxiFpBDFmDa/UFyL2kNANoQJqziWTxGDoDrFX03aY2ymBtrL3Qd9aNuTXRAVA+TkQu5cTRcw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781250204; c=relaxed/relaxed;
	bh=O5MzBBKZchkzfVSxnBOJAXhJ2T0QrM0FYAnwLYi+8eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpK2ASVUdpAtJ7uDQiTTVtuoPFiHl352pBDj0q9h4Kwp5P2/DaN9exR8hwoD4+79y+93UbsMsFCnmbfEr6M3+tPF244qf0wstUtEDAdAE5xMYb/nkmmwE1JGaPzBVrXB2gRETILIUhsOqVyPSzSYr3SePJ0fgScbNEsdvroKSFtDV71K2QFO24phMwna4kDMob/Ja/Cgk82HqVce8AXCFGeiTuUEPeLCZZlhpfRU4fNJ/84ovV49c2VdyQRR24OyMooElwf10Q2ykfljA85Pzl2avqLJMjR7HoTmWgK/X1MY0RI0A17Ec6ltZMX1o8Qe3Nh8lA+Zpvy/PYaedkyXLg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=ZElaZLm/; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=ZElaZLm/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcBMb2g76z2ySC
	for <linux-aspeed@lists.ozlabs.org>; Fri, 12 Jun 2026 17:43:22 +1000 (AEST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-460166910e6so317607f8f.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 12 Jun 2026 00:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781250200; cv=none;
        d=google.com; s=arc-20240605;
        b=GSh+ONmH2Aj1TMRVhTAUKBnJENxDBV27ixHH5/qIfp/oYjxwF4xGbeqFsEu621x7IE
         oPAa9do8ZxZgt7mhEGw9Sw9ar+3BlBkcG//lxfcJO4Bpoup+hYCv+2rA2TYVXBUUdFOn
         ds9GLaxZd1DaNLGSGvLEgtVcLq4tTCDNEWDDqg3Ad4TXNRq365suhLCsFKYOuntfZdLK
         5wTj/tf5BykSNT9f1qrpeCbQQAtuqDSS4RnwfiammhGOsfn/zLl5OF/GqBDGqCcDS7vu
         +wUtyKBuLxUeuo6dvnSlxyLOuAxYOGqmdlLyFj2QEFjiJk9s/iSIudKolIFQhoKdsPPt
         l0Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=O5MzBBKZchkzfVSxnBOJAXhJ2T0QrM0FYAnwLYi+8eM=;
        fh=lVxDyFQxr+rY+EhN9kjBJt1/CIByJKuUaCfLa9heGiw=;
        b=JynnsAsQX2q3gp89gtP/pfManMPZ94T0cf+YEBn7UDPmMmrrDtvAC0zmWmHSpfVOK6
         j8ssMAQMlJUwTXPOex8N9dUUtM/AbESmv0mNR3Xg38JXlP1/AfA8t+j//ONkKnx58hgB
         /708WgWf7s0g33wIjPBwczwtnKrpTuOdLDJyUqMcfkXrNR0sP7R2VzbU+THJUhAQWAaQ
         HJ7FV4WlzZkrZOWBZN0EnUzNdo2pLqv8dAnAtuzKYd5l3GvR6CK1kYZmzb69+AEg567R
         94xC93o0ji+6kcbt8i9SRQLEtq6p+k5Hk12YbRP93vLJ5dki9If9g6D6WQCwJza6WxQX
         5TyQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1781250200; x=1781855000; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O5MzBBKZchkzfVSxnBOJAXhJ2T0QrM0FYAnwLYi+8eM=;
        b=ZElaZLm/rungARPvjWHQsXq+2mjP5SOc/mCdFJ1NqsfLC31knj/Mtu/U+/nyUNIhFZ
         mNlCtec8aMwEV8zwY2Iis99yOwBsZrzzndYfehkgKLI8hGeIuN1ZIRtivfx/5XAxEdPO
         RMnmZANYTFUXuDPTRrtESjgQurpo99L6rXeGs1dID6DTt9bu81n+CTCcNWIy9BSaqqZ5
         1KomTC5Eu35ryAjsAr0/F9OEczs1Zwt3iadbgfyv9aU8pJbwQszE6pGd6msPCaLqy76E
         WQf55lhxKbRj3yK3UO4Qqn7yJUOwqfqhBzcK0UEu56g7/GXH6S40XAj8f+Wcg2AeoH33
         j9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781250200; x=1781855000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5MzBBKZchkzfVSxnBOJAXhJ2T0QrM0FYAnwLYi+8eM=;
        b=fNdmEnLx7iN2htMJCNxkCc3++H8g75ajcks4W0kgN17sleNHes1YawtFdLQfnZKU1N
         YYPWV0maLreafmg1GJOqXlQ29E3pWYLttPFgnaUQseYMVW6Pqt1sj0n26huM/N4FGdyX
         hOeyr7mSvm5RlbRWF+jrDEY/6pzriWs/krBHENYz/FiNG7ZdvZNeSsULklLKw9W1zw+K
         FcsmjCgy+MQkaRzTo5oaA49M3JVSsZwPkRXIDY41IIZQ5uHT1HRH4j9Vq0GJ9gaExiKy
         JvxceZc4Je6bR6+BC5f3An45uMoSB0/vc7fkX4LAXSBVLN4fG1CyV2s4gnFL2oE1mYCY
         xa4A==
X-Forwarded-Encrypted: i=1; AFNElJ8AiIqMdbahP05kfVd+szHiB+3HqzEFWbD0ShunJlrJ3FpsPF2HejO031BPZyNi9/XRwT2gVS21RnmGGuY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwCIjGN32fMRxF4YkFQufbW9MYtbo0N43/RGWM/z1+qEHdh2N41
	YE/B7MlO2vqG7e19OrwqugkxngbpdVZVN7l4ajYk1rOiXmJa8Tubtfg0VwrZ9hfAE2348gGiaJ+
	PAeVp05B96xtpzkMBbH5FgeRGXLFVCTdQRKHHpnNyoQ==
X-Gm-Gg: Acq92OFFh6HcXpMGcBpwSVa71d0OrRbhc1V/PK3oBmQtflyqUpN+dUMRTUHe6ynUAB9
	lyuTja0pXZMxthWxihi22fmB2bO3yHnHe+ZjqqXdivRnfa9zpgChfcKcrV5gwODnSnJ+qswszBX
	6xLXnME1oq3X2U/wHn0eOuF3AwWQjtnOIBTOKno/vpNYeOGFiEpGCpOHBZ9IU35YF+CS8yO5KW/
	Zk6yzgcF/Ch9zIQvUUVQOI46GWwpLexcL15dwO0ZE0NstbEjB+IY0jWw8bYJx0Hwgp5n32tfdI4
	5qmlajpBG5Hm/bDdq98AfFgoOJRFIE65Th6Ga0UlqtFcy0UQY4ePRWzpmzDAvxxKPZsV
X-Received: by 2002:a05:6000:290a:b0:43c:fc5c:a9fe with SMTP id
 ffacd0b85a97d-4606dba4105mr2253784f8f.20.1781250199806; Fri, 12 Jun 2026
 00:43:19 -0700 (PDT)
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
References: <20260612072341.278591-1-gregoire.layet@9elements.com> <e865e2e71a39c86a8afb6af49d9ebcf6839a9a2a.camel@codeconstruct.com.au>
In-Reply-To: <e865e2e71a39c86a8afb6af49d9ebcf6839a9a2a.camel@codeconstruct.com.au>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Fri, 12 Jun 2026 09:43:08 +0200
X-Gm-Features: AVVi8Ce5W6VsTL5wvIhDV4g3cp0NVrtH0vt8cfJM9zmJ1mlbq7raAsaetjYBOEQ
Message-ID: <CAFi2wKZE_m_xeggqKa=HxwaSuC2qMYNiBz=TjPgbX7BhQPyO5A@mail.gmail.com>
Subject: Re: [PATCH 1/1] ARM: dts: aspeed: g6: Add AST2600 pwm tacho controller
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

Too bad, I didn't looked at the right place.
Thank's !

