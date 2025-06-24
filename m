Return-Path: <linux-aspeed+bounces-1549-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218FFC77B7C
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Jun 2025 12:29:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bRPQG4vltz2xk5;
	Tue, 24 Jun 2025 22:29:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750768150;
	cv=none; b=U5HKBjyk/ah8VKZAHr5/UWrshWsoZvKI/lMMA17lwRtj9TPNYTxXdA/1/Wxi9I62ymMJv/v4g4bOcTCaPyqUw91v66xu3hFbskXsK2xaZs2P8qKNSoArK0Lwh5FGDljlV7YW7W6LtTwXGXrzpmf/OcKjyiEk3mq7TbiBJYhlaXT7ouXpBC1GQwpA8lChFyqqLp4M90VYwmVnn7b4TUCgYU0mCAMRMPrZiahUfTOqxYDmQQnlcjEPPqZ2Skm5Xwt1Hw9FMJHt73PhM+617pKt6BRBLwQzrf3WzgR8Pg1vOuRPQ406xWNavoBzFsmRkz85ddo4xk2SE2UCeUJldKijvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750768150; c=relaxed/relaxed;
	bh=bv1lKTHFFm3DfIi/TgcdlSfHSAO2gJzBqq986gjNAXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ML/1wSU8JvqwPX/drNSgqaZaN2Kb/tElL/4hUHxKQe28uGiqBIjLfbDsInVxXzrP3mCP6NwqGSwSfpVTNZyYDy1yb3XqI/II7YsXslGIlyYN+bytbZcUqp6x2qOYvwQDeIGyKIzInRE6HZNm+iZrUAMLvDiS4EfBosLcXdr2lcybOe/zC3BTSfZfrLRgZRDoi4birpi3daXr7Ahdkx2Yne4RLLqNahEqMOh0F2B440r+e63Xzjhsvjkg1t7o1EpCi2euK0poeg0Mx+wyfgLAHU8dZHFxdliSu1J31s6zxPuGquEN5GmI1GmsJ01/YM27o1iBbMbkJST+ZhYG6W0ZmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass (client-ip=141.14.17.11; helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de; receiver=lists.ozlabs.org) smtp.mailfrom=molgen.mpg.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=molgen.mpg.de (client-ip=141.14.17.11; helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de; receiver=lists.ozlabs.org)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bRPQD74wpz2xHZ;
	Tue, 24 Jun 2025 22:29:07 +1000 (AEST)
Received: from [141.14.12.217] (g217.RadioFreeInternet.molgen.mpg.de [141.14.12.217])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B1C1E61E647A8;
	Tue, 24 Jun 2025 14:27:53 +0200 (CEST)
Message-ID: <7b1f0f17-197d-4c57-b1d2-a9d8ec6ff398@molgen.mpg.de>
Date: Tue, 24 Jun 2025 14:27:52 +0200
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
Subject: Re: [External] Re: [PATCH] i2c: aspeed: change debug level in irq
 handler
To: Zhang Jian <zhangjian.3032@bytedance.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joel Stanley <joel@jms.id.au>, Andi Shyti <andi.shyti@kernel.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, linux-i2c@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250618102148.3085214-1-zhangjian.3032@bytedance.com>
 <63e740bf-cd0c-4671-9254-6846048b0366@molgen.mpg.de>
 <CA+J-oUvm-3G9GRCzjOd+j8K6iNs1piCFAKBNfwih49iFwiB4pA@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CA+J-oUvm-3G9GRCzjOd+j8K6iNs1piCFAKBNfwih49iFwiB4pA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Jian,


Am 24.06.25 um 12:32 schrieb Zhang Jian:

> Thanks for your reply and sorry for the late reply, I was trying to
> figure out why this log occurred, it's quite hard to reproduce.

Thank you for your reply. So few days and over the weekend classifies as 
instant reply. ;-)

Were you able to find a reproducer, or just rebooting?

> I traced all the master and slave states, and eventually found that 
> the behavior matches the description in commit b4cc1cbba519. The
> issue has already been fixed in that commit it was caused by a state
> machine bug that led to the interrupt not being handled correctly.
> 
> see: https://github.com/torvalds/linux/commit/b4cc1cbba519

The commit you found is present in Linux since v6.7-rc7.

> (The state transitions between the master and slave here rely on
> interrupts. When the signal waveform is incomplete (such as during
> power off/on), it may cause state errors or brief unresponsiveness,
> resulting in some log prints.)

Thank you for getting to the bottom of this.

Now that you ran into this, and have a suggestion, how the logging or 
log messages could be improved, please share.


Kind regards,

Paul

