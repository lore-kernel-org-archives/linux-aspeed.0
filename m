Return-Path: <linux-aspeed+bounces-5199-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA0ACC6B2D
	for <linux-aspeed@archiver.kernel.org>; Fri, 16 Oct 2026 04:33:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5X7H1qmSz2ygD;
	Fri, 16 Oct 2026 15:30:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b132" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792054832;
	cv=pass; b=UYN7pg3p6CTP2NlLrOqO+8LF0VoT6ZEz4jHt1jkKWkjwFyJps1RO+ILa2bAn7LAqObz5kXaR5DSQ0Jk1imIK+aQVv/Eu+U3A1/TUREnGUdzOYZjPxdlNZQaYa6+FzFP/mrY7M1LWaq5tkQpa6MKWOjL+EyDkRCK/K5PtA1nXkXlbDGYJvPhE2sX8C3wNEic/+vLHaV44lDk3ijSk0wv0VlYM6TymMTvS6hQp8bpG2S7Z8MVH0Ypee78sZlzLEEvLjDjq9XCZJhyimGdmy8fy1p3ND2e67xdxtieNXPwrXuZIHCsvYET0FV6QjZ3EU9ldvTZnCo0978DNHkoiI5EY9Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792054832; c=relaxed/relaxed;
	bh=H2bwf3Gv5oNr3T6PPFbiYLp5czeo2CNPZ2amlY5zFVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VAPCqKDpr1U1N6kxL00ER5TOme7jWSWlo92CsaO83ejB/4jmnod5dUDM3aq9BR0mhdAxMKr/84R1SgYeX3QDZ3b2ZItcgDhg9LfpuOMa+Hc6Vcq+jv1jCq3QkjcoAwH9Kmzez52TYZyq30iLPI0L01dtzfZd4UE6kzYLBKOLD5RBOWpeIV6kM3EsneUCZBMEPUsJHabcxil9XydQ3TAGMge3pi3Tl0UKdFIMGJDLiwGoHUUMqhQ5PMnRTXzMjXZfFahkWIOmTgYm9ghSQeouZD3wKZT17RaJCiITgk+p+GsDBbs/o3Tz82PvpwH0BK3heACYTH0y9SXr+oH/9CYrOw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=DS+8TGNV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b132; helo=mail-yx1-xb132.google.com; envelope-from=wenst@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=DS+8TGNV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::b132; helo=mail-yx1-xb132.google.com; envelope-from=wenst@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com [IPv6:2607:f8b0:4864:20::b132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j528t4qW3z2xLs
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Oct 2026 20:00:29 +1100 (AEDT)
Received: by mail-yx1-xb132.google.com with SMTP id 956f58d0204a3-67992884b02so906586d50.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Oct 2026 02:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792054827; cv=none;
        d=google.com; s=arc-20260327;
        b=VvrRwJgXiC9c4KLMxk7AHpgkvVx7eBw8MYZvKOJQ0ppVB8GKFMrLMwUFroOUABmtNu
         e2jUQIj7Hbv4yrOHyUX+F44eEYwR88hsRjHVVjgYpnYjxJjsvks1tUn3wiZ4eTBlcoSM
         IFCgCTsMUJIVxzU5sldC0YhPCb+5X3ivQ6k3nDEaj4uQr92TY1HCNygi5D9IYMldRyaK
         4ItxZf3MasDLk/VEVKl3KG9mximVuEzHSZGZn07/RtuHdxrALsMsnxXKlxHuIAtTmxzJ
         su1jPNotuVtJVP/T6TpTBD9iCSTGH3ps095CJp2LTeCn+bcuKzBIkrJqcJolCyKPX+er
         +qqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H2bwf3Gv5oNr3T6PPFbiYLp5czeo2CNPZ2amlY5zFVU=;
        fh=V7ugR9HZxU+KWO9Sifbc5+lhfGIRcgMpcGwK1BpP4FM=;
        b=rNDWosu1FaoDmvuuk1/QD8mVkJRNRHTExR3WFYEz9T3zPdyV2WnUsVYqWtiKboV0pE
         XRT2vbKYssXUsdAMRpv3Bf+ESIdkAgojc4hwNZ3JlxUrVckKpgKBAg5ABQyoM0Ue88XG
         esL5mToJOCcTwjXusK/4XFdmkkLJ+LA6brtZoNzwrp+DpJYntMQEEkDd78vZbgbwgEir
         ASrvZw/9hJ7n/JA3ZmVSsz4iIjJG1Mw8LdkUpGwIS1T+eM7YiXsHtGSm2Pro5RBJOldy
         sZgRWpbma0N1XZbILsYBBncHnVJRr9rqfZCxSf88XAHZx29SWE9ToKV2+cjvqxcc+tt4
         VMmA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792054827; x=1792659627; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H2bwf3Gv5oNr3T6PPFbiYLp5czeo2CNPZ2amlY5zFVU=;
        b=DS+8TGNVGkAZOAbDQ6/gTAdTtsi0UKmLw4EsNoYC5p/KxLc1IUZTSiIQn5+FNKuHwj
         U2tpQWLh5Yzs1Vnd2l3ErrcPFsXtWpnMC3q1pndF7s7ex1v0ygWg5vsmvyaHE5t6JjGc
         Tck62pyVlhIPm83bfmFIJXbRg5DF/4O/gU19U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792054827; x=1792659627;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H2bwf3Gv5oNr3T6PPFbiYLp5czeo2CNPZ2amlY5zFVU=;
        b=SGzsfnlDM34ikN18z0xVsYBnWXZb/lRq+/uPgxf/nSKzJsYgQEeNQ23UQitsr+YNot
         o4iAAkL3SSvZ4b2XHWvsFmuQAnpOX8k6LdqcIBoyERVRUlDqi/VtCLTui5a4XEgYGQSi
         KMJWnljBLIFgxpffbQNXhnQgIMw5hd5Exk2fx6USJJvGUovZ+lkFOgSTrs1RcfrhWckP
         fqDq6WGq3xDqb6O1f4q7x6T8tFhK5lkVw0FqgZAAIAJXe9nn/XJM0DYpFDiFqUfacMvr
         a+rM58tXhxAqwNU4pYTZkEoOalqcovGANX53UxkodKxY8RBAkjxGjsuLmbqH2xrnyXB5
         VryQ==
X-Forwarded-Encrypted: i=1; AKwUvByMCTsBXiVqZQq+zc0YSKe0ho7NBdIc3+V4iw/k2jEi1qjvzvF2apJDV2RasJ6gIP2lLa4ZYk/K/3INkfg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYL59zjx7RIuu/grynl00wSeWnCsk9fnChZrUxsTde8R7mStgEQz
	410tYLCd+3IaJDIobktjyMlujq8sba0FSu01Uc3tW2ltE3RouL8wc0+pQH0S2dbh9d4ZXXAPoEu
	eoX3ikmPEgl7RL27OROE4PiXY1YxuTU4gGsGXQWxO
X-Gm-Gg: AYBFou1I6SPYhVMkI3sFTRzNkTJ0ovLIBnnuuXcZfnMfZb8gSo3UbxveSQmvpLYmDjy
	uLQc1erYVXbtn5pLc7DLYL2M/2e2BFzMm4Jl6F6zWNBLZueOuRBU7G++ccNvVdGAt2bo0i4gxox
	8nqrSxh0WvzGcf3/ONU2zyugi6vcZ3Ni8M/tQ5raY3XD+5Eg56vrk8q40ExrBDQn1qm6XbhrcN5
	mOSgsKSrMu+M0AZtcVkBXpnznnI/1hDJbFwyzbPARJGFSS3ZaIT51sCeomxYagl1zhACU9MDV12
	DOQbFufwtrhkQidkdS0pc0mIBqghlQKcnj0woqDovNRglQ/Tpqi/E6+Rk9hqFrFY16s=
X-Received: by 2002:a53:ac9e:0:b0:675:449d:3d74 with SMTP id
 956f58d0204a3-679362786a1mr5012542d50.92.1792054826173; Thu, 15 Oct 2026
 02:00:26 -0700 (PDT)
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
References: <20261014082037.1774672-1-wenst@chromium.org> <20261014082037.1774672-3-wenst@chromium.org>
 <7020a7a6-332e-4fd0-a659-d82eb768614c@linaro.org> <CAGXv+5G1kgyumbj7wGf6rPFbg3spSO0zYmEkn-hZT4qUdJbytA@mail.gmail.com>
 <03375a31-0ac6-47a4-b0dc-6327080e1622@linaro.org> <b4c0761b-34f2-42ad-97e7-ab34ae776281@oss.qualcomm.com>
 <8d4d3ec2-3c97-4a46-97f8-048fdf81b853@linaro.org>
In-Reply-To: <8d4d3ec2-3c97-4a46-97f8-048fdf81b853@linaro.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 15 Oct 2026 18:00:14 +0900
X-Gm-Features: AclHuK909vzDVZhhmMGqz8RNS4kIz2k4tldUZDjIEfGnLkXIyAs5uz5oF7-pLmQ
Message-ID: <CAGXv+5G_ig=k-eH8Cp0ES70WxTHcBS2TVj9VmHaG9caROiAuQQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: usb: snps,dwc3: Fix downstream port numbering
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Sven Peter <sven@kernel.org>, 
	Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, Michal Simek <michal.simek@amd.com>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Peter Griffin <peter.griffin@linaro.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Yixun Lan <dlan@kernel.org>, 
	Troy Mitchell <troy.mitchell@linux.spacemit.com>, Minda Chen <minda.chen@starfivetech.com>, 
	Shyam Pandey <radhey.shyam.pandey@amd.com>, Wei Yang <yangwei1@eswincomputing.com>, 
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>, Hang Cao <caohang@eswincomputing.com>, 
	Li Jun <jun.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, Roy Luo <royluo@google.com>, 
	Yang Xiwen <forbidden405@foxmail.com>, 
	Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>, 
	Robert Marko <robert.marko@sartura.hr>, Xu Yang <xu.yang_2@nxp.com>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, Stanley Chang <stanley_chang@realtek.com>, 
	Ze Huang <huang.ze@linux.dev>, Aswath Govindraju <a-govindraju@ti.com>, 
	Roger Quadros <rogerq@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev, linux-aspeed@lists.ozlabs.org, imx@lists.linux.dev, 
	linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, Mathias Nyman <mathias.nyman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Cc-ed Mathias, the xHCI driver maintainer in case I misunderstood xHCI.)

On Thu, Oct 15, 2026 at 4:44=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 10/14/26 18:36, Konrad Dybcio wrote:
> > On 10/14/26 11:44 AM, Neil Armstrong wrote:
> >> On 10/14/26 11:29, Chen-Yu Tsai wrote:
> >>> On Wed, Oct 14, 2026 at 5:28=E2=80=AFPM Neil Armstrong
> >>> <neil.armstrong@linaro.org> wrote:
> >>>>
> >>>> On 10/14/26 10:20, Chen-Yu Tsai wrote:
> >>>>> The DWC3 controller can operate in host mode. It does so with a XHC=
I
> >>>>> compliant host controller. The XHCI has two downstream ports, one f=
or
> >>>>> HS and one for SS. USB downstream ports start from 1, not 0.
> >
> > [...]
> >
> >
> >>> IMHO having consistent numbering across controller types would be
> >>> better. This avoids making the USB core and hub code deal with more
> >>> exceptions, and also easier to understand and write device trees.
> >>
> >> I was in the impression the port number not necessarily reflects
> >> an actual physical numbering, and can be a logical number we would
> >> then map in the kernel.
> >>
> >> I don't see any issue here having base 0 for the bindings and then
> >> converting it to base 1 for the XHCI port numbering.
> >
> > I thought base1 comes from the USB spec and not just XHCI?
>
> This is my question, is the spec says: each USB Host Controller root
> port shall be considered as a port of a Hub and numbered the same way,
> then fine, let's use the base1 numbering.
>
> As I understand how USB is architectured, all downstream ports of Hubs
> are numbered in base1, and the whole topology is based on that.
>
> But here, we are speaking of physically separate USB busses, one
> USB2.0 and one USB3.0, a controller could also have 10 USB2.0 ports
> and 5 USB3.0 ports, who knows. The way those will be numbered is not
> part of the specification because the specification only the defines
> the topology of an USB bus, like PCI(e) defines the topology on a PCI(e) =
bus.

No, the XHCI spec actually specifies how to identify the number of ports
and which port supports what version. See below.

> How we aggregate all those busses to abstract them to software is not
> part of the spec, we chose to declare a fake root Hub with a physical
> downstream port as a virtual port of the root Hub, fine but this is
> purely software abstraction.

As far as I understand the implementation in Linux and the XHCI spec,
the XHCI hardware registers give the "maximum number of ports" in
HCSPARAMS1. Then there is at least 1 "xHCI Supported Protocol Capability"
entry in the "Extended capabilities" section that describes a group of
ports (offset and number) and the USB protocol supported by that group.

Using the example given by the XHCI spec on page 330 as figure 4-35:

    XHCI port 1: HS on physical port 1
    XHCI port 2: HS on physical port 2
    XHCI port 3: HS on physical port 3
    XHCI port 4: HS on physical port 4
    XHCI port 5: SS on physical port 3
    XHCI port 6: SS on physical port 4

The DT would be something like:

    xhci {
        ports {
            port@1 { /* graph to HS EP on USB A connector 1 */ };
            port@2 { /* graph to HS EP on USB A connector 2 */ };
            port@3 { /* graph to HS EP on USB A connector 3 */ };
            port@4 { /* graph to HS EP on USB A connector 4 */ };
            port@5 { /* graph to SS EP on USB A connector 3 */ };
            port@6 { /* graph to SS EP on USB A connector 4 */ };
        };
    };

> We may only use the hardware IP port numbering in the bindings, not
> the software abstraction.

And we are using hardware port numbering. It's just the numbers used
are the physical port numbers from the XHCI registers, not the logical
port numbers on the root hubs.

In fact, we could say that the port numbers on the root hubs for XHCI
are made up.

> We could use the base1 to describe the DWC3 ports, but how to describe
> all the physical USB busses a controller can expose ? We may not limit
> the bindings to USB2.0 and USB3.0 ports only.

Technically, there is one bus for USB 2.0 and one bus for USB 3.0. But
currently for XHCI in DT, we describe the hardware ports directly,
regardless of the USB protocol they support.

I don't know why we don't describe the root hub, but maybe it's because
prior to XHCI the controller and root hub were the same entity? Even for
XHCI, the root hub is more of a logical entity.

And AFAICT, the hardware registers don't distinguish between ports on the
USB 2.0 root hub vs the USB 3.0 root hub. The port control registers are
just in an array, indexed from 1 to maxPorts, i.e. the physical index.

> How about the USB4, does it use the USB3.0 port ?

I'm not familiar with USB4. A quick search says that it can tunnel
USB 3.x, DP, and PCIe, and it doesn't have its own USB HCI defined.

So I'm thinking the USB4 controller would be more like a nexus node
or multiplexing node, or perhaps like a USB C connector. It has input
ports for all the protocols it can tunnel, connected to their respective
controllers (XHCI, DP, PCIe). The binding probably would be very messy
if one controller supported multiple outgoing ports, as each downstream
port has a 3-to-1 relationship with its respective upstream protocol
interfaces.


ChenYu

