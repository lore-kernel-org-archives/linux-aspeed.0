Return-Path: <linux-aspeed+bounces-2837-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F12CCFA0D
	for <linux-aspeed@archiver.kernel.org>; Sat,  8 Nov 2025 04:41:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d3NYJ6VXgz3bfX;
	Sat,  8 Nov 2025 15:41:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762470711;
	cv=none; b=CE8ag1U72S6RKn3ITERVw1Jl9Y5FJ7vRPxTwMc1NyclUXnlL9iyX5sJkgeMFaIEnMVdF+Y0bSDM0Uq7IcAJ7XQMJ8kHLlvR7twTYylKWlCjm4HJ51MUXeTEHiPeTDLN4HuihkoQNlGlwDA6wd7vako2nSuz7/SqBcw1bpXumCYzEHqx0IIcW9CL4dH19HxWKBkXuAHquPEROf6DvLmXEo3IKSNAad09xPULPbO8z7+fIFba8jOA0Av+Rgl2NPEZcrZjKWz9yvTimjrlvUCWda5lFv5gQvHOx3U/P+Q4VQ8HUrwpx6AZ7W4yDvULShgDHUzfk7XCGHQxNqOOCVjXCfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762470711; c=relaxed/relaxed;
	bh=QXr28wg8D7Sns2qkEeLZq8j8Ed6Tt4Rhy3ccABxhAR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=j048BrDCiQesk0aEKL26AuySD28k6mvbj2mzX+Mg8HSk22Jnpw4XlNJUBLruXgwzZQLm7f1ghLgyNhCbQDX7hwnd6uyghaRy1FzpMjokLryLQuy9xwgPDLokfjhUmj0Q1wN/t15/GeFznT86TfhiJGT9wrssX35+IbMdt6OyDLZYpMVJl9bP+j1eMSTXFXobYYXx2h3wZikkC/MftU+vMfq9R3XyYa6i55zRenFGMwMvBnW6KaziND35OlwK/PRuH4s08yG41cj3WyPyO5uYk3qTimK8onKZoVa+GhNaMgppmujt3QGBfNr8pV8TaWfmVLOq5rbQ/Rp9pRZ0G6JIOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ffoNfZt+; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LEvNrYRk; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ffoNfZt+;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LEvNrYRk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2dHV2PRfz2xlQ
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 10:11:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762470703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXr28wg8D7Sns2qkEeLZq8j8Ed6Tt4Rhy3ccABxhAR4=;
	b=ffoNfZt+4EwKYQZhUq9CmQ7krU9OWDgy2PcqqjcavAJ+302QZWMBE3OQp41akYkDml5xQN
	t3j3R2sh5X1HxLx4VN/LXhD7SB3EphW4bAd6qdM1rpG4YJAvhcd1ojiAtG0LH5EI6ap5y4
	JxnRcLKT+5R8dCkk6Uzz3dJI5ySmWHw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762470704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXr28wg8D7Sns2qkEeLZq8j8Ed6Tt4Rhy3ccABxhAR4=;
	b=LEvNrYRkaZz4jYvuQQ2XF/Tj/zEhk3ISbDBoM+ig1fEs789q/7jRKLJW4Z9NkfO+htCqHj
	AeCnigrl/oAa0/z04pipHlhjoOl5adfRvLPAnZovOaLu70tk48XupLErXAwUq3qHia9COj
	EFOPa1+EjA1Vxm6Q0LETYuNKzbp8S5Q=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-at4zc_5bOJuN7PNNJTm3hQ-1; Thu, 06 Nov 2025 18:11:42 -0500
X-MC-Unique: at4zc_5bOJuN7PNNJTm3hQ-1
X-Mimecast-MFC-AGG-ID: at4zc_5bOJuN7PNNJTm3hQ_1762470702
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b1c1d39066so39066885a.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 06 Nov 2025 15:11:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470701; x=1763075501;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QXr28wg8D7Sns2qkEeLZq8j8Ed6Tt4Rhy3ccABxhAR4=;
        b=k5lGKI4q1OP4jth9thAPcwZKOSK7fUwBzFfE4eOK55L+hRPrxNfrKMl+rM+TC3Wifd
         DHqcF5VcAZgCwIWZHLf7k3tA8ps4OozpRhxVTepAm6RBCfX2lpGe7kw1jIoKvqMz6x0+
         88zvNeGYtPIye8PCMTnZ4RVVj7aiRlOgQFHa1Q5Xu81j6fQjP1h5op2S8rAizV4rwURY
         DtIV3727zZpT+zWnoS5cThk3jGa+SfXvXQ4mrV76UaNXUwNb0ZXE5VdDoeBRKS+uqcgY
         HQjKuhiotKorymjqzfxo/QpqjwSQYqx4Z3r4hLo8OHDO8p8EbLGNtMEW6W03rMUuNhao
         HGDw==
X-Forwarded-Encrypted: i=1; AJvYcCVp4aVymDom0Z+0mwcX4dTFVjMUyoSFXApyj2PoDc1Z0zKITBrTOuTDjIV53vHKqzV1zSTuYewfSm+t/r8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz7/b6Em6WmLoakhHrAIJr3srINnKySJVV4Xi1MbzTpNwiVVmiS
	TD0J0S0XZiAswdoY30upUycjMkr2dJQN2HAPcfA+aVbwgRyyRdf8miSY42+cELrJoDyhAh8I2eX
	F4tasbG7hDte0rL+pB1RtJJZ9ufnRc26N826+5r1eU23uCA5GkGOuHqKpdXrJALcQknY=
X-Gm-Gg: ASbGnctkB1ouaytusPXpQIKGESFGXdJZinNpHzV3s6cjQpUpUBNfcAz0RE0VbHIeqbm
	M7AxiPQCeC42Cy6t1l7H61TViek+PjI5+PSOImuwqfq6XmoT3+YFMBmYhLfLHl4v5oHur3XLsY5
	zNp2adeJEJ6NhahdevD01Lckl2NcrtF5RvjyNwcYVsgLm5Bv4uS7RUGGI9VWfuCNSOBAm6lXMKZ
	ZQFL+X0ivJLBRzKhyGIiHg0Kt++HiYVbIdh2z2kxCgYTERGb4fwC9NThmWNgotjRrEXWJ2tO9jE
	bEJt6P1UE343RX5dUy6Qck7o5brRcqG6lUgXsL6VCsTARiI0vRcAVloA6Y+rxclL9LgVx10RcnM
	HU1fa2UlucTAhVGKceOu5twMZEZVIy7QL6Q==
X-Received: by 2002:a05:620a:31a4:b0:8b2:43f7:c07a with SMTP id af79cd13be357-8b2452a2167mr193181285a.22.1762470701620;
        Thu, 06 Nov 2025 15:11:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVetiFRByjjykyfxVb5wuiQuE2TgT+5D6JC3vwCG5rcTtdy2u5B3i2rGtKd9IxnXFml+2NaA==
X-Received: by 2002:a05:620a:31a4:b0:8b2:43f7:c07a with SMTP id af79cd13be357-8b2452a2167mr193177985a.22.1762470701157;
        Thu, 06 Nov 2025 15:11:41 -0800 (PST)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2355e56c0sm281056785a.14.2025.11.06.15.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:11:40 -0800 (PST)
Date: Thu, 6 Nov 2025 18:11:35 -0500
From: Brian Masney <bmasney@redhat.com>
To: "Winiarska, Iwona" <iwona.winiarska@intel.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"sboyd@kernel.org" <sboyd@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	"mripard@kernel.org" <mripard@kernel.org>
Subject: Re: [PATCH] peci: controller: peci-aspeed: convert from round_rate()
 to determine_rate()
Message-ID: <aQ0rJ3ahOV0gmUVM@redhat.com>
References: <20250810-peci-round-rate-v1-1-ec96d216a455@redhat.com>
 <aMatZAX6eFI1RmDH@redhat.com>
 <28dc3bd8aeca7e3164747960747f75060c596704.camel@codeconstruct.com.au>
 <aPEZSY6RC-UVclxN@redhat.com>
 <ba2e6b78e59afb7c89e5022770a142ec8c31659a.camel@codeconstruct.com.au>
 <2025101759-runner-landing-374b@gregkh>
 <2975918e3f3a7de245e93fbee52335acb78bb23a.camel@codeconstruct.com.au>
 <2025101721-twiddling-huskiness-4852@gregkh>
 <13566a08eeaed313ad789abcae1920d9b00483b0.camel@codeconstruct.com.au>
 <d53256b35ee7089607463c66bb4a8c3420faf058.camel@intel.com>
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
In-Reply-To: <d53256b35ee7089607463c66bb4a8c3420faf058.camel@intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3KDTsj4_gjrfuuhKIDU80RffyBBpv9ASo1_-xQp16EM_1762470702
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Iwona,

On Tue, Oct 21, 2025 at 09:01:23PM +0000, Winiarska, Iwona wrote:
> Sorry for the delay - for some reason this entire thread didn't land in my inbox
> and I just found it now, randomly browsing mailing list :/
> 
> I will sent it as a PR for v6.19.

I'm just checking if this patch should show up in linux-next by now?

Sorry to be a pest. This patch, and one other series in another
subsystem is all that's holding me back from removing a legacy API in
the clk subsystem. I'd really like to get these dependencies merged for
v6.19 so that I can do that cleanup work in v6.20.

Thanks,

Brian


