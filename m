Return-Path: <linux-aspeed+bounces-4698-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8C8C5B572
	for <linux-aspeed@archiver.kernel.org>; Thu, 13 Aug 2026 14:23:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLSK40l9vz2ygn;
	Fri, 14 Aug 2026 00:23:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786631032;
	cv=none; b=nF0Fbef5b1qHARllPxr/2hXUDRppGpK1ds+lKGexFndUZTuzX2EmBPQZ32eKLEpUirzrYZlFASOk3iOqwN9AguJJFFs6F6EW9FVYOY5V7sZ8jho/sG/0kzZgj00Rq2bvLjA1vAzFPW4/gGQhlILvRg0nAlbyu5ff2ffKWXAZXJkkGpeBV6YA7hhg0BVTrdvSuWMTnXaBGUO/Hta4Ixa4Atk8GmscPoxxpP15d2AJgUMEl5ooQv0Ul42ZyJXNYqNVP4pkTdgz6DBlHkAQ681wLmDrGwQbpRqNZA1b/rb9rknt464z/4RlVmqKect24t9hSe3nxJQw4ZgPiY+N6K29Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786631032; c=relaxed/relaxed;
	bh=3zAK75b8ZUtjKJXv+z/knfiDKVadFa2L6rKVWPT2qQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bv7s3yeSjZlHkj5kqT3jF8DR5ldWEaIeu5w5E0D8osNLYuWaBJIwQj+rasWMbzgTQeGnqyVLARLElsS46VEx/Ntx8rXlat3kbYL5dNsYMu80JxU7Rx+aySa46TkMzY8Ka4KQ/8it20tRtpJk6OEsQc6nS4JzQihlOZXjEPaUifWUk+XX/DQfXf4a2d4oEvrtv5vaft8dbWKrWmBRMvxFdJKSFW3yCLtNsA5Ghw3jDagvoAiM6JGIOrsCeD/WPzv4bVC7zQHx3E7SgUU/flNulX6dYT1bcffLFBfFmNFn0GUhR7WtrGznNiTP5GQJZA84TZEK0oBsrxz/xa2CiBbpZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=V4LYLXsa; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=V4LYLXsa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLSK2248rz2yD8
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Aug 2026 00:23:50 +1000 (AEST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso7313005e9.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Aug 2026 07:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1786631026; x=1787235826; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3zAK75b8ZUtjKJXv+z/knfiDKVadFa2L6rKVWPT2qQc=;
        b=V4LYLXsajczdMCv/hhLW81lEgV6FUgxmkkBIx4n+y2jyf7frurCUEr+ELCL/MgvYnh
         97vo+Na08Egv3ATKIc8BXHHhFUSGyLhoQRJnb0l9YZUM/O8S9yLVPSD+eZndqrRet8Zq
         m7AmftD3zbFHBZED+5YX5OkyxFHooj0Cg2U8Gb0UTLj20nlFqEthEf0ffCvniZfgrgfj
         L7GjT777Cl88o1Fb/Jplb8g7TTD7Okem0bgfigQz7uM5Gt7JGjA+2xHa4s1/o4B1T2Qi
         J+JdSY4VwL/JVyC05RzBG57QdWO+PsXLe85SWpKPbosv2UjYHauuPbRF9IQ3rFY4z693
         c07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786631026; x=1787235826;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3zAK75b8ZUtjKJXv+z/knfiDKVadFa2L6rKVWPT2qQc=;
        b=aaYveB9gB7alrf5cyU/KXUSHJmdIMSlLBawMLJE5/NNiu7LAbtEe6HLF20ye4J6FRQ
         r3fh/LKhr2TPvS1KD+NZpfQKkvHsMzSlldLgKdowjGBxgMTGuJqWsQOpcArM3UbGH22i
         x5QaDyodqmhCsTwIRN34iCjqvh9M4gm7jnAtY5W0FSoFN/Yk+hyKW6kP+rrEQE8RKqnW
         TIvnjV0w+K9l5+UseB3FkqpKVOC2BmbrvAdi0zkz8Wq+XJH/lRm6ukKHZgMTgSxOxxQM
         /s6N+sVwK/otqdPYY5E1t0DX+WB7CPKrwag68TbWiuj6g8821YGOQJHsAXTSxWoMq3by
         dbkQ==
X-Forwarded-Encrypted: i=1; AHgh+RokCtl0B2Zr2LS5V0/KoOO6WOzgrGNSyM/w7YWyZhGa3p+ycRuvxlKoJB1E2cigk6WFQW3L0h9KpMUUN6g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxAF6LQO9H4pysgQVxSfZ44akrGaWHemiETgHn0mVLh5jVzSA8+
	S+98UWK4+g1Nqe17N/G0z+SCSlpu821qz2Vml7gYR/41i9lOb20V/jmuTbYvfIYuWpI=
X-Gm-Gg: AR+sD13/VbVp64ewIrr2vSGozYuQQN5AmiBlZUM5BDJVZO90o49ZtrPY/PrdCQxacxb
	LrmZp61/eMLD1fpUJ9L/ZYLjOSz4vdWHEuNb/ZzBl9C9b3dWMiCMalkUHl9SyBv3FnQzPt+BHEi
	YUovQoRl0eqTmk3K2rWABHBAwM8h1oxCnAdUnFwXZUdFGGzucGFi6qyMEI44HFeulISPtvoSUNI
	1OQLzK1cQId342x4oJtxcVmptJnffpyfuXZWsCAVeKJM5qxvpJ6qndDt1NHjHe9A3nSw+H4Nxr2
	fjmkm6Lishm8Kuh7lBHToBxUNLc0PUcMUg184GzqZ2S5BfWhq6vA5Oi3iPWRq3N7ZcfFi3zWWaB
	kTfG0egoMfRxUxNAIKfAtcsjphpd8SmdW7tRVX7a4EtdKUgtvxLNqwN1V2WyZSPqtxcdTtyN6SO
	GGoGH+zfySQfpOv2EnsWz70fY3EgYaS+7VvabyCjay/UXimjRRD+gB3HYDz+SIOSQgjXTAxdc3H
	ZEnRRrAdSmjYELnNqegdDweUxdvDSboAKozVZh33JOYcTHSwkbH
X-Received: by 2002:a05:600d:6409:10b0:499:84fc:4548 with SMTP id 5b1f17b1804b1-49984fc45c0mr29737445e9.5.1786631026583;
        Thu, 13 Aug 2026 07:23:46 -0700 (PDT)
Received: from ?IPV6:2a01:599:447:e518:cc7c:e59e:1489:db94? ([2a01:599:447:e518:cc7c:e59e:1489:db94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981e2e266sm51262395e9.2.2026.08.13.07.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 07:23:46 -0700 (PDT)
Message-ID: <15d1ced4-2400-477b-800d-fdcca80559bc@9elements.com>
Date: Thu, 13 Aug 2026 16:23:44 +0200
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
Subject: Re: [PATCH v5 4/6] soc: mfd: add ASPEED AST2600 PCIe BMC device
 driver
To: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk,
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, lee@kernel.org, =?UTF-8?Q?Gr=C3=A9goire_Layet?=
 <git@gregoirelayet.com>, andrew@lunn.ch, jacky_chou@aspeedtech.com,
 yh_chung@aspeedtech.com, ninad@linux.ibm.com, anirudhsriniv@gmail.com,
 linux-serial@vger.kernel.org, mfd@lists.linux.dev,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <cover.1785932211.git.gregoire.layet@9elements.com>
 <51db5e5bb5bf44dd5ab893b8d547291f04e1d3c7.1785932211.git.gregoire.layet@9elements.com>
 <178609182923.193353.7287772568467157519.b4-review@b4>
 <CAFi2wKZdJ3LxJVDqC2K79T0JhoOOWSj=ZmL9pB+Lka_aXDXatQ@mail.gmail.com>
Content-Language: en-US
From: Tan Siewert <tan.siewert@9elements.com>
In-Reply-To: <CAFi2wKZdJ3LxJVDqC2K79T0JhoOOWSj=ZmL9pB+Lka_aXDXatQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/10/26 12:36 PM, Grégoire Layet wrote:
>> But you're adding the UART devices here which now means that the core driver is
>> doing more than MSI interrupt init.
> 
> I might have misunderstood but this is creating the UART device by
> using the 'serial8250' driver.

You're right :face_palm: I haven't had enough coffee when I reviewed it.

Sorry for the confusion!

Tan



