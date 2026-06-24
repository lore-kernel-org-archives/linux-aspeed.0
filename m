Return-Path: <linux-aspeed+bounces-4298-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA84CDB47F
	for <linux-aspeed@archiver.kernel.org>; Wed, 24 Jun 2026 12:09:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glgjQ3v7Vz2yZ6;
	Wed, 24 Jun 2026 22:09:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.72.192.78
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782302986;
	cv=none; b=evNnTHuR6rQf28Hty/FnJfyY7mAqt2Qww6N6qHgGkitVtKw14BVXQGHpxPNDvK5s2fjADOEeal/3h1k/6wxidqNNWNaL042S+n2vwOZznRsa6ZztzUMpyDlkrSjygjkR7v02xIHvgaX25Gp9+olpmzHGB/6QGX7/KNCn57w29VMN3W7+UxXrV1PfE1gNqKc15TC5TQYT+G0fx8W28vBx6fKhckXygs61zun+B9GZNaloqBYQ8E73e/lhZOM+cjefbXDnpf5Iy5my4JIzggi435yakqlJbmQvIgCyvwToYKRmXlS8whn/iovWBdiAmaD0N8TEvU6u06tSVDwAC2ng5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782302986; c=relaxed/relaxed;
	bh=jDznzImR+9b+XJTCIZr9Pz79SZTSLcqvoXZNw6/wWNE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=cuyAcsXbbSK2s5AhyftO6L/nr7to3dbG8T932IRQvRJtetSeuMFcB32lI4yUoVOXsGMo7aW4nqPWIdZ/0spjdpfBVJkEIayLkKlrgO0X8Q0Fh4ojjQrc0FBYQIcTDvexySqm6DC+Tc6uBUAVIjtvbZgHjLtKoXX9DTZdpzrHVbgyFNW1nP4QkXS6ptK2901HDci89NKGTuG3FFO+MsiUb0P52OSBha6sWo9Y/zjJLjt3KTt7pJo4nCb/jcNIqp0Gk0qBTvw2wsMpSqdhToHS6yLy55Gx9vPiJjT8cth3JoX2dK5sCWvXVTLCs3sKD026uLwMvHUkyAYrcHF5XZn+lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=NIJCoAil; dkim-atps=neutral; spf=pass (client-ip=217.72.192.78; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=NIJCoAil;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=217.72.192.78; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 370 seconds by postgrey-1.37 at boromir; Wed, 24 Jun 2026 22:09:42 AEST
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glgjL3xgMz2ySg;
	Wed, 24 Jun 2026 22:09:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1782302977; x=1782907777; i=markus.elfring@web.de;
	bh=jDznzImR+9b+XJTCIZr9Pz79SZTSLcqvoXZNw6/wWNE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NIJCoAilU6/sjI+dAFcGS0tMBm/Qwwp+wGAqumNX/QpV1uLkMY9gf4+7utQ5f6kv
	 3+qGivqK3HAsd3dCF2wps+c+88d8hceV9tUdUtda0YhPiceZ5cOVZC0ZVX8rEs5ek
	 /iZ2asOLxlLboy75BIKgg2xIqLYbE3EsW1ghgg7j1KGmATC1a7c8U8mrsgqzn3UnZ
	 TnqzCHsBB6oMn4yDxvuYyyLcSBJoDM7xnjOm9WfyYMWFnBKRRJaYdVJ8eV6pda3mH
	 64YI8f//+c9Wr+sTRHPgQvSncO4CdKUfmgqJIEweFOJ5jjS3Xu2S9c4ese5gCbRVd
	 FPUJxoBS5xPplwR7tQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mi53D-1x6lG02cjZ-00fhb0; Wed, 24
 Jun 2026 14:02:53 +0200
Message-ID: <e78c2122-d10b-41ce-af94-45f573306c43@web.de>
Date: Wed, 24 Jun 2026 14:02:48 +0200
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
Subject: Re: [PATCH 5/7] soc: aspeed: Add eSPI flash channel support
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260313-upstream_espi-v1-5-9504428e1f43@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iJdliJcoGoSfPjjLZqKkVQPJNk+J6tQaDz1aQeOEtjoksIFcv9a
 aEub8HGMj5q6p+CAQ2e95cuuJUIy7JfJ0nlDbhRd8X45gnHAIF6uPY2VNuqm/u1uOVGgR+x
 HVWcn9k48hfuf19rAEcX0mrpDECHtW881JXd5evMqPuXk4K7UdM+aohu3CBhtvQEMyV7qH1
 /xpNq4TIZTk43L4UwV1mQ==
UI-OutboundReport: notjunk:1;M01:P0:rNVm4B3H5qE=;nPz7KMEDCv8WADFVSRRK27kfSsW
 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

=E2=80=A6
> +++ b/drivers/soc/aspeed/espi/aspeed-espi-comm.h
> @@ -0,0 +1,62 @@
=E2=80=A6
> +/*
> + * eSPI cycle type encoding
> + *
> + * Section 5.1 Cycle Types and Packet Format,
> + * Intel eSPI Interface Base Specification, Rev 1.0, Jan. 2016.
> + */
> +#define ESPI_FLASH_READ			0x00
> +#define ESPI_FLASH_WRITE		0x01
> +#define ESPI_FLASH_ERASE		0x02
=E2=80=A6

How do you think about to use an enumeration for such data?
https://en.wikipedia.org/wiki/Enumerated_type#C_and_syntactically_similar_=
languages

Regards,
Markus

