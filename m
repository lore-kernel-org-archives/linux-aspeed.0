Return-Path: <linux-aspeed+bounces-1148-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E7CC36008
	for <linux-aspeed@archiver.kernel.org>; Tue,  1 Apr 2025 07:15:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZRfRV1cTQz2ygD;
	Tue,  1 Apr 2025 18:15:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.15.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743491749;
	cv=none; b=c/jhWZe+XjBQe42GhKe0Fdj8bQt0BYwCdQTuIfiFG29+XfLCWgbuYuEohGIKVoVRqMaEhQuUDgrwecMZPOzLCdaGnyJaltbfSDZZTlTI1rG4/P1Bnsr5daqeEvl0oTC7ddjUjP9x4u6cQ7M4o4TXGSj/F41R2kmFpY4Od9KMwKFExv4k6GJy9zckC8IaHjpI5D6+M3I4d4fYUVJf18c4X2Ls1YUPiNk6fw/xa0+gRGHULmuGT5Wnrn74w/aNCacF6JTlCPDOTDC6l6ThkfTrnDtONZpGGQXsyzzFR0eMUgkZdk1Y7oQop/DURghVCXxYDb+3QUVk7uL8LgzNmfRBLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743491749; c=relaxed/relaxed;
	bh=Ufr8jWio+k3mAwH6vRZeNy2DQEzSjS0mBeDw/wYCdD4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Pu6tL5yxXRw1urixfE9EDWneXNKutK57lFkuAMSwK1mSr/Jrc5EP16b9+JoAWoAlJ7c6ude2fp11NE+z/FTD9vG1XWjBCLhiWFMHoJ1WzaftHs3fe1i23vM3HRddS6JIznd6FI3xiM/zvkZLgBT1JICgPYREUSldUSUYXJPAuFyLwHKWLwJBjPqdNeYU0+n9+vBONPRan6LzPP5lYrjGxYVfwHuOBdh10fmE5FaM2vhDoJGyLBjhGWKb1KiGHUvSfgUiS1QX22QFJL+Y9tuo33Z7rzBGUkh+Ze2HTcc5Pq7BilyOwFNB0UDiTcwOQROkIfcfuxKUyiYTbDwd7b7XZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=widx1Zio; dkim-atps=neutral; spf=pass (client-ip=212.227.15.3; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=widx1Zio;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.15.3; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 373 seconds by postgrey-1.37 at boromir; Tue, 01 Apr 2025 18:15:47 AEDT
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZRfRR1Wccz2yf1
	for <linux-aspeed@lists.ozlabs.org>; Tue,  1 Apr 2025 18:15:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743491730; x=1744096530; i=markus.elfring@web.de;
	bh=Ufr8jWio+k3mAwH6vRZeNy2DQEzSjS0mBeDw/wYCdD4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=widx1ZioDtdpjurlfr+BfKggyrhEV3NvwOhfEpEaNmlSPAycW4dDOnCqyp/n6u0m
	 NaJBhau+ilht/YAgkmY0BGWDWCP9LQuDYjncCxavqwoWSDipP9sIjNcK9CSUjpa8W
	 nlRKr9bL0ksDW8ktDGu5whUhW7YbCj78spJ5NV/Q/3jBhbyz12D4qWAojQ/HRYCN0
	 dp04CgKlo+bgCfu9zuoUxeja1Ybpro8OHZll6FPQShAgFsOjTUAphurft3IOmtDF4
	 I/Mf60Y8m9/cA197xNJha2JGnJ8YhxD2t7svPatYL52p8djsESoRahbTgfJxb3ocy
	 ON/JDIdagvxOX4TfFg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.54]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MAtwr-1toHKj15fl-00GGYs; Tue, 01
 Apr 2025 09:09:20 +0200
Message-ID: <03d87a25-02ea-4e4a-8d3f-c2fcdc4d068e@web.de>
Date: Tue, 1 Apr 2025 09:09:08 +0200
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
User-Agent: Mozilla Thunderbird
To: Henry Martin <bsdhenrymartin@gmail.com>, linux-aspeed@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Arnd Bergmann <arnd@arndb.de>,
 Bjorn Andersson <andersson@kernel.org>,
 Herve Codina <herve.codina@bootlin.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <20250401033935.17617-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH v3] drivers/misc: Add NULL check in
 aspeed_lpc_enable_snoop
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250401033935.17617-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9ghQMBunowstGfr7Qbdl++g5f/BvUsX0AoqlPh8HYvKL8GZYMsX
 yZRQOWRRNANFr4jw2YfJLK5EUbUmnVuuo5hJwu5tRWtS9qgDOAmpFJN5ZUeZY3fAv1uXZub
 RMxnWZDvwUIR/Gk68FCUk72oaFPQdMhOFkgBxBjRH+6uf5v2boobf9GcQSk1/SnGrJuZqXW
 TZfhrRgSY8F1Rp7gXIaHA==
UI-OutboundReport: notjunk:1;M01:P0:AVsIm+6RSYk=;PrlffSMgd7hpKDqnRezgtqkWjFw
 ZuXIDWOOhFXZRp/sE6CqYGeNWsWGVdJlbiv2FLmnBPHTESSttB+NbnYPrqABu+Dd9fMdMmyiJ
 RB/lF1Kn+JgOYgdyQG8qHKodS1Q2Mz8LULEGuO4E7HWRMiuPiC3dN5uc49Iz1ZWDF8Z+rO0HW
 WdpARtLj89PAtIS4mKeGqHk6JEiK/spI55Z6rXclNUkmX9kWV+DHVDdPPRYJj28SD29aRvCwI
 +Eek5lhq/Hy79CyZfnRz8CwACKaybIRXnKqxyfRnPRMdmci5zSq5lps9z5Xtcjau6oR7bbyXI
 5zNmGLTsbduGfugEaRmiIcksmObTgCGX0m/Ko0M4vBJ//QCN9yw1EtdKpFx+UFoQKiD1566lG
 HVMcG2Np6cAIxaXq9hBYOaDVPLGEA7TLEBfzjme38hi2NyLyZUTEFFMBCOX6Y+jIzkOACl/O8
 x6T720TLEGyJKjdTJ54D3R7HQYjMXVE5TRkEnygFunNjhDlm4zmp9oQp8ij7wp9di1vEle+7f
 pZkkUigMVz0xYCoM4OaEaA6FlFoaxkZgkcl3KCgxcNaLQwUAwQ3aQz1AFILm4t38uIEDazCL/
 xM1UhF7g4B3qlfSwwE4cGehWN9LlPbOYfDFRkKsPcHWQQ39VCf25wQY/V4TSAj0eeKnG43EeS
 VHnvSSgWki8aDlK8qZXuvJJS7kT/uzGXvZTazGGI7hlZUc0/OqLrhYENi2AALgsawk185f5z8
 xtOH0YkInY0WKCDBXWblDzsgCz9AJ8xHZ2IXxni1Squu8ea7p7i9ddWEIgog4CBMFS0zNMDUz
 7xu02iE1sTnuXRcsEaCckEavgYtp7l90+wDdG0FfJ24ng2IHqq2dkZXSOsMmYSw3Vx1QU/22q
 tXnyaKVhQdJ2QMwQKrrmOARzZWI4LDP8meNY2MbSDj2scPrI/l9iAhjI9XsNgyb9LJFd25Wlg
 zcvIZUuZ7EqtSKLYXWkDZ9KfHPImfz5Nvv2dGh9B7JoaK0L1OqLStiB9DQMY2jKRqqoY2qAoU
 qkjE5ghUZ2avqLE2gKEjdyetxl6dksR6KFrPSRw0zIzgWSsv2b18dnfqDX7niv33J6izTqLAX
 jBPB8/o7pIrGymY8Kts2xneb4oehzwIgcrffJ59Em+uao9KBK/rtPwIxYjvMAEKV6VhOOIp0s
 CYNCoCcYYGKfL8H4WroBxccw6R9KGe9BD2SHvVRGGWBNaS3ZSvW4B81tVYHh/MCMLMiKJLMcd
 i2+wek0mzvgyjzG9gHvlSqAc4P4gQ8cIj+rQjhwed56OXNwEi+O1Jyl5IO4MS7QPwDJqIHjqS
 fIUnSg1cMgpViH5m7nNqwVFbq+ZeZnEEdZC71c9CzipHoPAgOPTN0xHvXsvA/U6mTi04sGeDC
 dd6Y48FwROIn5rCGRhEtStxkS3PJsg9Bn5LvTILmqRE1UBkKnFVzATShRIkrtMFGnFyb3abMD
 70wcHQ1A+SqC1OfJO2YS5UTaNgDsVPGhH8lVcJrAVSIaak2Wf

> devm_kasprintf() return NULL if memory allocation fails. Currently,
=E2=80=A6
                call?                               failed?


> Add NULL check after devm_kasprintf() to prevent this issue.

Do you propose to improve this function implementation a bit more?


=E2=80=A6
> ---
> V2 -> V3: Simplify the arrary access and correct commit message.
=E2=80=A6

* Would you like to avoid a typo here?

* I imagine that there is a need to offer such adjustments
  in separate update steps.
  https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/Documentation/process/submitting-patches.rst?h=3Dv6.14#n81

* Please choose a more appropriate subsystem specification.
  https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/=
log/drivers/soc/aspeed/aspeed-lpc-snoop.c?h=3Dnext-20250331

* How do you think about to append parentheses to a function name
  also in the summary phrase?

Regards,
Markus

