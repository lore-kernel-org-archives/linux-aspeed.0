From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 19 Oct 2019 21:25:32 +1100
Subject: [PATCH v2] ftgmac100: Disable HW checksum generation on AST2500
In-Reply-To: <3D78AA04-A502-4A9F-87A0-0D62D56952AF@fb.com>
References: <20191011213027.2110008-1-vijaykhemka@fb.com>
 <3a1176067b745fddfc625bbd142a41913ee3e3a1.camel@kernel.crashing.org>
 <0C0BC813-5A84-403F-9C48-9447AAABD867@fb.com>
 <071cf1eeefcbfc14633a13bc2d15ad7392987a88.camel@kernel.crashing.org>
 <9AA81274-01F2-4803-8905-26F0521486CE@fb.com>
 <f6d5cb45a9aa167533135c5b218b45b1d210d31a.camel@kernel.crashing.org>
 <529EF9B4-DFDE-4DB7-BE26-3AED8D814134@fb.com>
 <0ef567e985ce3fe821cbd80265f85a35d16be373.camel@kernel.crashing.org>
 <3D78AA04-A502-4A9F-87A0-0D62D56952AF@fb.com>
Message-ID: <72d1a78d7807b1bda00e1bafe0c2ecefe267918b.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 2019-10-19 at 01:31 +0000, Vijay Khemka wrote:
> Thanks Ben,
> I will try to add some trace and test whatever possible and test it.
> As we
> don't have tcpdump into our image and I have limited understanding of
> networking stack so if you get some time to verify ipv6, it will be
> really
> helpful. 
>     

You only need tcpdump (or wireshark) on the *other end* of the link,
could even be your laptop, to look at what the generated frames look
like and compare with your traces.

Cheers,
Ben.


