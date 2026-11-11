Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA2A606B01F
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Nov 2026 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHGSC6rH
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPzCY5T1Sz3bbf;
	Thu, 12 Nov 2026 09:46:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794404956;
	cv=none; b=fXePj1ugKrw3FYV+P8GrHipWPAb81ja0I3qhIJtGeaG1S6rJ3+PylQS3DjLtbPFbXgHodjIN+lzWirjP4ugS43LCYVqweENKtiuUiMzrIK7sRMNbQZ2tRgeQPFyeUGnN3As2IwgkWd1lBX1LtKIR+SvaGgf9s0LY2+RiylmbYUn9z16Gu4MGYzQopOwiwGtYr6VIhiLqzr3cy/hSAwhgyMBH6WnSWiPWJuBsGhRTEGdDpzaqCLnl/ohKZSQzjAbTgJ/qNdTXg/sz0JG0Mb4Oh1Ezh3WWg/Zk0tZisOM5S0FCFxBDs0Av3GuKp68lzeSyg6SXALtAnSENlqQglh4BxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794404956; c=relaxed/relaxed;
	bh=Qdx8SBFr5A9el3l62V1Hnpyo8SLW7HjNDS/vMXmANvM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ef2px4eaOQAJyRCpFqIxFru2PMuWNZ/vAEwHsKmUsK8TzIwRVDPj5ozVtMY/IUGK6z90fa94rhPdhCQ9yAxd4Hjzc0XZ4GyEnzBJ1pMCczW15Jh3CWP/eh7cybTbVz4hX2upXqM1JwpidsKMEao48LBnL6v1u1lGxNwy0q9YUSGgAhPVDXcQeRGBLb73z9ks/Luz6xsslDMzPbF1w6AkL7ndKlKOoPWv5xoQisYZeW7oGfIBPXfpTPqNfpTuRP7kWIQfyWlK3xqQKQdrd53OBjOJba32Hx9rnuovkTjQXNoOlDFqIF/dzemCxN+SR4W0Mve1+6Mw9ASxyvSbxxdHnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHGSC6rH; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=hverkuil+cisco@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHGSC6rH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=hverkuil+cisco@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPlHb64mGz2xWt;
	Thu, 12 Nov 2026 00:49:15 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 112CE60DEC;
	Wed, 11 Nov 2026 13:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C871F00A05;
	Wed, 11 Nov 2026 13:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794404952;
	bh=Qdx8SBFr5A9el3l62V1Hnpyo8SLW7HjNDS/vMXmANvM=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=kHGSC6rHES3fHGZkuagSOTPK0LWKUZKCjuI+lKf1BasID5OyztlT+Ko/nNpHMz4Sv
	 vPAcVMYZPLUMmmqJCkf1oJjzzW6wkhqQ8ypErW107oHctP34/qcyCdss4xUTb6qQja
	 nOqGHv5GsAovhkdPZxCk1ybqg3zw7k8AXnC2viWd6wc+BVvA6sXa4KHjdNry0+KKQ3
	 M9neRAmq4YT8GzC/oY/GKN2OGEC1piS7TW9gn7ccAXrbMDsGLeqgqOQ4Ui0G7OvsxZ
	 aUxrSMvyzFwDzfCJUFgYI6yA9/fWRUlZxJVj5/nuV3CRsGjZXBe78pwJwitdKROhku
	 Fu43Uec9NT9ZA==
Message-ID: <5b068d22-4f46-4f82-8914-ffed5a0f6f0f@kernel.org>
Date: Wed, 11 Nov 2026 14:49:08 +0100
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v2 0/2] media: aspeed: order probe cleanup and last close
To: Myeonghun Pak <mhun512@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Jammy Huang <jammy_huang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
 <billy_tsai@aspeedtech.com>, linux-media@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>
References: <20261109235731-aspeed-v2-0-mhun512@gmail.com>
Content-Language: en-US, nl
In-Reply-To: <20261109235731-aspeed-v2-0-mhun512@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Eddie or Jammy,

On 10/11/2026 05:58, Myeonghun Pak wrote:
> This revision requests the IRQ after its dependencies and synchronizes
> IRQ/work before manual probe cleanup. The second patch fixes last-close
> ordering and keeps the engine available until VB2 release completes.
> 
> Compile-tested on ARM64 with LLVM, W=1.
> No hardware testing.

Can you review/test this series?

I don't feel comfortable merging this without your OK.

Regards,

	Hans

> 
> Changes in v2:
> - Rebase onto managed reserved-memory initialization.
> - Remove the research sentence and Assisted-by tag.
> - Join the IRQ and delayed work before manual probe-failure cleanup.
> - Keep VB2 release before normal last-close hardware shutdown.
> - Drain the IRQ producer before cancelling resolution work.
> - Balance IRQ disable/enable within stop and check STOPPED before power-on.
> 
> Myeonghun Pak (2):
>   media: aspeed: join IRQ and work before probe cleanup
>   media: aspeed: drain IRQ work before stopping the engine
> 
>  drivers/media/platform/aspeed/aspeed-video.c | 38 +++++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 13 deletions(-)
> 


