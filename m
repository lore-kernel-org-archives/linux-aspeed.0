Return-Path: <linux-aspeed+bounces-4313-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F1CC43458
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Jun 2026 08:56:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpgBX0nZzz2ySS;
	Mon, 29 Jun 2026 18:56:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.15.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782723412;
	cv=none; b=DXUc71dwwiWL+07O/0PKQj/078pUhORWu0u40Efpo33X5UGc4k5BvraVHkNL29/CjU8DoFDqo+8L300buOIUjAP1AKxWx2nwjQIiZuE56mdIL281YU3hK4QkREYWMbmTmgUsF7M4UrovrkCOcX8hbSqM+pabTPa7B0FU0lITJM+6pHaMRN7W4wamh1/ynkhfAyYp2QqRlF+PbgLNdpN9+7ae7Yiq8srTtzbkeEvjLXmXpuWDAhTRXTe3rL2c8DC/byCxUmXjEyxo4RHXdV72JwTmYqS9AnY9alCfGzuPf9IEAKREuXoqrZ4b/lenVmjqEe+eqb/Zcijs2qS/0uS5KA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782723412; c=relaxed/relaxed;
	bh=sHGQep7ELFkSFXFgF6ohC/kAmip8vIV1u9toDMPmMJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgVLOk54H2BhPTIgo5XAO0o5yuLlpm5UVPONUO901Lglze2v6FIcTWk2pi+twuWdAgdz5IZ9jNGiqeo3B6D32u269rvK//GAjI6c6SU5qGB2zQ9ztdaCXbC5zjR1+d2YRCxUntwK1E7YeL5pU5gKqNVHlHfxh1ZJQ6g7392v7OTC0zTr5eG8J0iSd0mYR93MPIpLUkM0Z7jOrYgk62AYMfikbAamSJIrrPNVBmcx5IXtO4UVZNPek7PMgBT0BM9NtjkfEjyxAzAe6ekxuZIdQffInez9hbWZAcDqdZ4smO1AdKq9PiWfkBbDCqvv8f1ZtEWetlEaEOIZamHqY0Nr6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=HS86n34e; dkim-atps=neutral; spf=pass (client-ip=212.227.15.4; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=HS86n34e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.15.4; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 361 seconds by postgrey-1.37 at boromir; Mon, 29 Jun 2026 18:56:48 AEST
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpgBS1Jdvz2xYh;
	Mon, 29 Jun 2026 18:56:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1782723402; x=1783328202; i=markus.elfring@web.de;
	bh=sHGQep7ELFkSFXFgF6ohC/kAmip8vIV1u9toDMPmMJE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HS86n34eT0kHW/LUgZKgJc86TtsO6T673Uav7VWtgR2fqTPCxz9Gqd1MIxnYiyxH
	 kuHmf2D/iUv8rjtxwW/vRcJNNphi0kalY8IKpqX16fPoEZ57QJuC35BPvm3L7fw5B
	 M5Sg4hJwqEL0FRcPrr5eqhlLhMF9jJtt+jCVQAz2LHpFsThPyVBaZ0IZ7tehks2Yt
	 I9lZw+7j5jyaWRycw0Wf2KdeFgIs40H4uV+OEn6i8RtRkC7JYWJBLYtanQ4b0aOEX
	 eWkoXCLcEJAL/2A3Nl0T2sGwBVfEXJKrTvSOZjxnjNOsY1fWF2WIOIOijawYY68oI
	 hG1NcwWy7yowfSrxyg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6pYY-1wlGpi13PC-001Y3E; Mon, 29
 Jun 2026 10:50:24 +0200
Message-ID: <1df6b921-368e-461a-af01-d453a3898cf7@web.de>
Date: Mon, 29 Jun 2026 10:50:15 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [5/7] soc: aspeed: Add eSPI flash channel support
To: YH Chung <yh_chung@aspeedtech.com>, linux-aspeed@lists.ozlabs.org,
 openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Maciej Lawniczak <maciej.lawniczak@intel.com>
References: <20260313-upstream_espi-v1-5-9504428e1f43@aspeedtech.com>
 <3ab543eb-ca09-4d75-b75c-b8a4c71b2173@web.de>
 <KL1PR0601MB4276C2C831B257898AAB363190E82@KL1PR0601MB4276.apcprd06.prod.outlook.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <KL1PR0601MB4276C2C831B257898AAB363190E82@KL1PR0601MB4276.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O7xlh/3cxMfm7JNJN+7muJKOH6hzFljVBaT95Mv64SGWo4IBCry
 6Pelh3l7niIZMbDAhodQycE8UDxZQgZV6c/NInikprdJ/8l1XiMDWna1P/ciwRLQUucrHnM
 iLj5kBNXTSJ0+eQKr5n9s9ta6oKU1sc8132tRNmwgfPt/CsBMwLUqS7EUhYi22lg1JedLvl
 8DiovMciqBwkQFYpgE9uw==
UI-OutboundReport: notjunk:1;M01:P0:c2o832KoCqs=;gfYSEAwty6vp/JsuN4MCfkq2UH9
 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

=E2=80=A6
>>> +++ b/drivers/soc/aspeed/espi/aspeed-espi.c
>> =E2=80=A6
>>> +static void aspeed_espi_flash_rx_work(struct work_struct *work) {
=E2=80=A6
> Thanks for the suggestion. I agree that guard(mutex) is helpful when a l=
ocked
> section has multiple exit paths. Since this worker currently has a singl=
e
> simple path, I would prefer to keep the explicit mutex_lock()/mutex_unlo=
ck()
> pair for readability. I can switch to guard(mutex) if you think it would=
 be
> better in this case.
I hope that development interests can increase more also for the applicati=
on of
scope-based resource management.

Regards,
Markus

