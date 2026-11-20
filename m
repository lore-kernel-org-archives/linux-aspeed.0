Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDF5606A337
	for <linux-aspeed@archiver.kernel.org>; Fri, 20 Nov 2026 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=BJUFhlCP
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWPjt5tBdz2xqJ;
	Sat, 21 Nov 2026 05:58:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795201090;
	cv=none; b=BaCyqrjb+meWqVBxkHqHf/C5vHTRRTcB+eAY1BBIZnJp0xsx95WRUznKeviMzVt1iEKxbgmHrM0ou96oNbMFASXL7Q5xyVa4CnIoTKyZxGOkseWSFcFPBbbfYGKBc7gEFa3aYMA/eIXnx9f92Hiv2IXSEhmLd20kWcuqIZPLGVxxxtZ7Ar/6rl6BBXfu42FyU7bymLRUKTdvbLO29gpDP1RpfrLkSOzJ40EX2rZ0gvyMN7COA/LlMgbI9Ffz3bHH2oiQkKTn/mIVk+yPht6EoJs2S4xDPAZmK9OltXGzvDVrZA316zjjw/hHWzU1Dqi/q2Z/LbdpurRw1GIaGTEVKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795201090; c=relaxed/relaxed;
	bh=H4FGooqlFWyqGkh+aQ/av1H1BBYV40gcH/hlMVUd0co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e81eui2F8G0CiNqrmEvGp2+jLcNpqQM3xSKR8gf3SNkPKI4baizYPlbSLgKZ77RqqkS4Bl0qtecJ/3PFTTGEF8rDh55+0kEh/eNfwv7sAJch3qGxAt3oDKonbMoaJOaC+iS10tGsgQ4iYiArUKie3hbH6uu9+0ePdjU9XmPo4fu0XgebhlsSvfonYVfbzs5A8nMDdIGPVDRoly1I0aIOH+XDQ+D68HQORyFhmsv0WyKP92FAmsR5MONGO5e6RCTwZhRSKVPSC9a9YLHPH6eFzhkwjb+bmCrCNM0DHON9MecoLJOIuAHDYCvORwxAG7zyK1GO0PGr11vzuGL/qaVx2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=BJUFhlCP; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=BJUFhlCP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWPjr5f0Nz2xly
	for <linux-aspeed@lists.ozlabs.org>; Sat, 21 Nov 2026 05:58:07 +1100 (AEDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4bb69f5b161so7992105e9.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Nov 2026 10:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1795201084; x=1795805884; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H4FGooqlFWyqGkh+aQ/av1H1BBYV40gcH/hlMVUd0co=;
        b=BJUFhlCPXrATcwjlUilxs5Ha6wtkHpXgc17IVwyXRyhK4OKrTW2cnAJ077sYIVTfMA
         ZiIQtncePXcjSDilLbA0qLDaVK7WWxO7pVOyPeWT/d1K3bnc5yq/+nX8JivKpb3IFTEM
         p+zko7EkxKSgJziMfusRrpo+2exdTIZb9Bi7q/dT+2fI16JSFuTaESMLHEKrGEQ7aesf
         r+OPvK5M7J3B/RtJTE7Erjb48oUaJLmSG0U4ZjmAWZV4HVhchdMrla3rIqV2YbZLECfC
         dbGphlJ19jouytE6S3v8JfIpq0T66xKBdlwhTx8m2GZS6ATs5tikLsD0lapst2cKgUFj
         gAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201084; x=1795805884;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H4FGooqlFWyqGkh+aQ/av1H1BBYV40gcH/hlMVUd0co=;
        b=D2c4wR3Hn7MDjW2SIHYrroY7s69yL1eCxavwUD2VlqisYwZwN5Toz0EqL3V9RN1k0X
         e5REVASRhZx2DbF+9JA0/sE2pKps595Qk83Ece3hln4MdDQbpgeF3tflkuvF7JwLYqIl
         phuBSugK6v5BWcaTCYu9NzWFPtKi5HerlD7t24+uHy7FgJZ2kcDkxNeWFDQkrc3eg7YQ
         4i0PSc7c9VtTG3JEZhBsPQsnlGHW4Kx+2l5p5OLH0nWxfwVOGZyprzaTTmi6oAJWXvqg
         zhPKOAFlHw19/EumYbqIt/b51ZeFLKYUCGtXb7N2/sNAE7tE7b1b3YNpYaSzOaTOE80D
         IzwA==
X-Forwarded-Encrypted: i=1; AL+hErHazRJNskNXVEzLICFIj54vddP1EXRORK+7BOVoC2yRe95Nt6KYsjSv0RmW7j2f4dmYFEAa8I6uo2/+ng0=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z91gIhiVnkIPojcDxUCxulgd/UlbIyEEAEvQB41QzIlTdNLQdbc
	+mgKVSmJacZV55V98/QQ07TuCvKejCkk3/w7rVFXpdKJlK9M3/MgwBLAS45XG+t3jkg=
X-Gm-Gg: AYBFou2Rwv3dhiwUBg6OnNAsFccTO2QTy55yKXMySIjq8GYPmuwuf+ARp0Q2CGd01H3
	RkaQN8DCLIAgQeyqmoic2c6R3Fon8bSTVxe286ihLXNrStbhWt8Q97+HmJ4JEuTXDAzS5BjJt1P
	kQIleMgQzy+/KxtD5T05/jEpev8QLyzZAeWK3R2NIrlVmftXkjaU04WK+6/rySWg9BVF7XYstOf
	Kd5LGFnCixZB0ND0luPFbPs/UYC6NwJoQs111fwwhIzbWiyJfp9VgCQtOD6DoCxbNv+mDSQ+GXR
	ALHfPNdcyIWbX0cy2asX7CqGLvU6ayTd7MHFB17UR7XG2d3nJIjkF88mbdk7dwjU6UKTNUTI2gZ
	Z0uF3+r6A/5oESTmaAndAs4Ly4QrFjf/bBe93Z8n68hQGseCh62uaV8MT6wx/iYKlaEQUCE2GxP
	xIX9l35PYQBAhC2LrfDXDxztoHWtpQ3iJYqOc/3b1TgOpNtGOJ57Wi/NvtWEtNpuZXxoP1W2lSg
	ESOJGnDnOGSxfMbPRRSa3Zy2NpQZLEXgBKdrvGa8e4HyjlKnESFrbEiA2IoTVWN2goxHqby6TLF
	ZLMHJA8OMM8Ofhy7rDW0kRFWOp8Img9HWayo8EmsPHmCWEdjV2R5jdjSjjInZDUcktOXuyJD7/R
	HUNt/98dbNAE71TfGiwwCYNWKplk=
X-Received: by 2002:a05:600c:3491:b0:4a2:c2b:a91b with SMTP id 5b1f17b1804b1-4bb8880014dmr95550835e9.10.1795201083545;
        Fri, 20 Nov 2026 10:58:03 -0800 (PST)
Received: from ?IPV6:2a01:599:241:b744:2c96:9736:bec3:7db8? ([2a01:599:241:b744:2c96:9736:bec3:7db8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442693sm97210445e9.1.2026.11.20.10.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 10:58:03 -0800 (PST)
Message-ID: <9519e889-8c78-485c-a31d-28df8b7cecc3@9elements.com>
Date: Fri, 20 Nov 2026 19:58:01 +0100
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
Subject: Re: [PATCH v2 0/2] nvmem: aspeed: Add read-only AST2600 OTP support
To: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, ryan_chen@aspeedtech.com,
 billy_tsai@aspeedtech.com, neal_liu@aspeedtech.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, srini@kernel.org
References: <20261113034213.158390-1-prasanth.padarthi10@gmail.com>
 <20261120174440.123487-1-prasanth.padarthi10@gmail.com>
Content-Language: en-US
From: Tan Siewert <tan.siewert@9elements.com>
In-Reply-To: <20261120174440.123487-1-prasanth.padarthi10@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/26 6:44 PM, Prasanth Kumar Padarthi wrote:
> Hi,
> 
> This series exposes permitted AST2600 OTP data through root-only NVMEM
> for userspace diagnostics using raw offsets. It adds the SBC NVMEM
> binding and a read-only driver adapted from ASPEED's downstream driver.
> 
> Changes since v1:
> - Add the separate binding patch and rename the driver nvmem-aspeed-otp.
> - Poll once after a 1-us delay; retain the 100-ms timeout and log failures.
> - Initialize read mode once at probe and stop commands after a timeout.
> - Use a fixed secure-prefix keepout and check the live SEC54 range on reads.
> - Simplify copying, locking, configuration and Kconfig help.
> 
> Tested on B650D4U (AST2600 A3), OpenBMC Linux 6.18.24 and upstream-based
> Linux 7.4-rc1: repeated reads, cross-pair reads and 40 reads from four
> concurrent readers passed. A 12-byte range matched the saved ASPEED-derived
> reference fingerprint. The 7.4-rc1 RAM boot used the working OpenBMC DTB
> and initramfs and also passed the final-pair comparison. ARM zImage built
> successfully.
> 
> AI assisted with driver revisions, validation tooling and patch text,
> using the downstream code, review comments and Neal's hardware guidance.
> Hardware tests were run by the submitter.
> 
> Prasanth Kumar Padarthi (2):
>    dt-bindings: arm: aspeed: sbc: Describe OTP NVMEM provider
>    nvmem: aspeed: Add read-only AST2600 OTP support
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

Again, please fix your threading... Other maintainers and reviewers 
already told you in other threads that sending a new revision must not 
be "In-reply-to" to the previous revision. See the "Explicit In-Reply-To 
headers" section of the submission documentation [1].
Consider the use of b4 [2], which can handle it more consistently.

Tan

[1] 
https://docs.kernel.org/process/submitting-patches.html#explicit-in-reply-to-headers
[2] https://b4.docs.kernel.org/en/latest/

